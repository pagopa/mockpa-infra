locals {
  default_ilm_policies = {
    logs = "default policy for the logs index template installed by x-pack reviewed by PagoPA"
    metrics = "default policy for the metrics index template installed by x-pack reviewed by PagoPA"
    "logs-apm.app_logs" = "apm reviewed by PagoPA"
    "logs-apm.error_logs" = "apm reviewed by PagoPA"
  }
}

resource "elasticstack_elasticsearch_index_lifecycle" "default_log_index_lifecycle" {
  for_each = local.default_ilm_policies
  name = "default-${each.key}-ilm"

  hot {
    min_age =  local.default_ilm.hot.minAge
    rollover {
      max_age =  local.default_ilm.hot.rollover.maxAge
      max_primary_shard_size =  local.default_ilm.hot.rollover.maxPrimarySize
    }
  }

  warm {
    min_age =  local.default_ilm.warm.minAge
    set_priority {
      priority =  local.default_ilm.warm.setPriority
    }
  }

  cold {
    min_age =  local.default_ilm.cold.minAge
    set_priority {
      priority =  local.default_ilm.cold.setPriority
    }
  }

  delete {
    min_age =  local.default_ilm.delete.minAge

    dynamic "wait_for_snapshot" {
      for_each =  local.default_ilm.delete.waitForSnapshot ? [1] : []
      content {
        policy = elasticstack_elasticsearch_snapshot_lifecycle.default_snapshot_policy.name
      }
    }
    delete {
      delete_searchable_snapshot =  local.default_ilm.delete.deleteSearchableSnapshot
    }
  }

  metadata = jsonencode({
    "managedBy" = "Terraform"
    "description": each.value
  })
}
