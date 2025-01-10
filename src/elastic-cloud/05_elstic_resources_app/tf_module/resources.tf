locals {
  data_streams = { for d in var.configuration.dataStream : d =>  d}
}

output "conf" {
  value = var.configuration
}

resource "elasticstack_kibana_space" "kibana_space" {
  space_id          = var.configuration.id
  name              = "${var.configuration.displayName}"
  description       = "Space for ${var.configuration.displayName}"
  disabled_features = var.configuration.space.disabledFeatures
}

resource "elasticstack_elasticsearch_ingest_pipeline" "ingest_pipeline" {
  name        = "${var.configuration.id}-pipeline"
  description = "Ingest pipeline for ${var.configuration.displayName}"

  processors = [ for p in var.configuration.ingestPipeline.processors : jsonencode(p)]
}

resource "elasticstack_elasticsearch_index_lifecycle" "index_lifecycle" {
  name = "${var.configuration.id}-ilm"

  hot {
    min_age = var.configuration.ilm.hot.minAge
    rollover {
      max_age = var.configuration.ilm.hot.rollover.maxAge
      max_primary_shard_size = var.configuration.ilm.hot.rollover.maxPrimarySize
    }
  }

  warm {
    min_age = var.configuration.ilm.warm.minAge
    set_priority {
      priority = var.configuration.ilm.warm.setPriority
    }
  }

  cold {
    min_age = var.configuration.ilm.cold.minAge
    set_priority {
      priority = var.configuration.ilm.cold.setPriority
    }
  }

  delete {
    min_age = var.configuration.ilm.delete.minAge
    dynamic "wait_for_snapshot" {
      for_each = var.configuration.ilm.delete.waitForSnapshot ? [1] : []
      content {
        policy = var.default_snapshot_policy_name
      }
    }
    delete {
      delete_searchable_snapshot = var.configuration.ilm.delete.deleteSearchableSnapshot
    }
  }

  metadata = jsonencode({
    "managedBy" = "Terraform"
  })
}

resource "elasticstack_elasticsearch_component_template" "component_template" {
  name = "${var.configuration.id}@custom"

  template {

    settings = jsonencode({
       "index": {
        "default_pipeline": elasticstack_elasticsearch_ingest_pipeline.ingest_pipeline.name, #fixme count index
        "lifecycle": {
          "name": elasticstack_elasticsearch_index_lifecycle.index_lifecycle.name #fixme count index
        }
      }
    })
  }

  metadata = jsonencode({
    description = "Settings for ${var.configuration.id}"
  })
}

resource "elasticstack_elasticsearch_index_template" "index_template" {
  name = "${var.configuration.id}-idxtpl"

  priority       = 500
  index_patterns = [ var.configuration.indexTemplate.indexPattern ]
  composed_of = [elasticstack_elasticsearch_component_template.component_template.name] #fixme count index

  data_stream {
    allow_custom_routing = false
    hidden = false
  }

  template {
    mappings = jsonencode({
      "_meta": {
        "package": {
          "name": "kubernetes"
        }
      }
    })
  }

  metadata = jsonencode({
    "description" = "Index template for ${var.configuration.id}"
  })
}


resource "elasticstack_elasticsearch_data_stream" "data_stream" {
  for_each = local.data_streams
  name = each.value

  // make sure that template is created before the data stream
  depends_on = [
    elasticstack_elasticsearch_index_template.index_template
  ]
}


resource "elasticstack_kibana_data_view" "kibana_data_view" {
  space_id = elasticstack_kibana_space.kibana_space.id #fixme count index
  data_view = {
    name            = "Log ${var.configuration.dataView.indexIdentifier}"
    title           = "logs-${var.configuration.dataView.indexIdentifier}-*"
    time_field_name = "@timestamp"
  }

}
