locals {
  data_streams = { for d in var.configuration.dataStream : d =>  d}
  application_id = "${var.configuration.id}-${var.env}"
  dashboards = { for df in fileset("${var.dashboard_folder}", "/*.ndjson") : basename(df) => "${var.dashboard_folder}/${df}" }
}


resource "elasticstack_elasticsearch_ingest_pipeline" "ingest_pipeline" {
  name        = "${local.application_id}-pipeline"
  description = "Ingest pipeline for ${var.configuration.displayName}"

  processors = [ for p in var.configuration.ingestPipeline.processors : jsonencode(p)]
}

resource "elasticstack_elasticsearch_index_lifecycle" "index_lifecycle" {
  name = "${local.application_id}-ilm"

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
  name = "${local.application_id}@custom"

  template {

    settings = jsonencode({
       "index": {
        "default_pipeline": elasticstack_elasticsearch_ingest_pipeline.ingest_pipeline.name,
        "lifecycle": {
          "name": elasticstack_elasticsearch_index_lifecycle.index_lifecycle.name
        }
      }
    })
  }

  metadata = jsonencode({
    description = "Settings for ${local.application_id}"
  })
}

resource "elasticstack_elasticsearch_index_template" "index_template" {
  name = "${local.application_id}-idxtpl"

  priority       = 500
  index_patterns = [ var.configuration.indexTemplate.indexPattern ]
  composed_of = [elasticstack_elasticsearch_component_template.component_template.name]

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
    "description" = "Index template for ${local.application_id}"
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
  space_id = var.space_id
  data_view = {
    name            = "Log ${var.configuration.dataView.indexIdentifier}"
    title           = "logs-${var.configuration.dataView.indexIdentifier}-*"
    time_field_name = "@timestamp"
  }

}

resource "elasticstack_kibana_import_saved_objects" "dashboard" {
  for_each = local.dashboards

  overwrite     = true

  file_contents = file(each.value)
}
