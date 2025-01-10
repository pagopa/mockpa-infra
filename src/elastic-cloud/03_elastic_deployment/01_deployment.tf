resource "random_uuid" "uuid" {}

locals {
  deployment_name = "${local.project}-${substr(random_uuid.uuid.result, 0, 6)}"
  realm_name = "kibana-realm"
  kibana_url = "https://${local.deployment_name}.${var.location}.azure.elastic-cloud.com"
}

resource "ec_deployment" "elastic-cloud" {
  name                   = local.deployment_name
  alias                  = local.deployment_name
  region                 = "azure-${var.location}"
  version                = "8.17.0"
  deployment_template_id = "azure-storage-optimized"

  elasticsearch = {
    hot = {
      autoscaling = {}
      size       = var.hot_config.size
      zone_count = var.hot_config.zone_count
    }

    warm = var.warm_config != null ? {
      autoscaling = {}
      size       = var.warm_config.size
      zone_count = var.warm_config.zone_count
    } :  null

    cold = var.cold_config != null ? {
      autoscaling = {}
      size       = var.cold_config.size
      zone_count = var.cold_config.zone_count
    } : null

    config = {
      user_settings_yaml = templatefile("./configs/es.yml.tpl", {
        kibana_url = local.kibana_url
        tenant_id = data.azurerm_subscription.current.tenant_id
        application_id = data.azuread_application.ec_application.application_id
        realm_name = local.realm_name
      })
    }
  }

  kibana = {
    zone_count = var.kibana_zone_count
    config = {
      user_settings_yaml = templatefile("./configs/kb.yml.tpl", {
        realm_name = local.realm_name
      })
    }
  }

  observability = {
    deployment_id = "self"
  }

  tags = var.tags
}


