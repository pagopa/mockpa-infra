
resource "azurerm_resource_group" "shared_app_service_rg" {
  name     = format("%s-node-forwarder-rg", local.project)
  location = var.location

  tags = var.tags
}

module "shared_app_service" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v3.4.0"

  vnet_integration    = false
  resource_group_name = azurerm_resource_group.shared_app_service_rg.name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-pdf-enfine", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.app_service_function_sku_tier
  plan_sku_size = var.app_service_function_sku_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-pdf-engine", local.project)
  client_cert_enabled = false
  always_on           = var.app_service_always_on
  linux_fx_version    = format("DOCKER|%s/pagopapsfengine:%s", module.container_registry.login_server, "latest")
  health_check_path   = "/info"

  app_settings = local.shared_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  subnet_id = module.shared_app_service_snet.id

  tags = var.tags
}

module "shared_slot_staging" {
  count = var.env_short != "d" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//app_service_slot?ref=v3.4.0"

  # App service plan
  app_service_plan_id = module.shared_app_service.plan_id
  app_service_id      = module.shared_app_service.id
  app_service_name    = module.shared_app_service.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.shared_app_service_rg.name
  location            = var.location

  always_on         = true
  linux_fx_version  = format("DOCKER|%s/pagopanodeforwarder:%s", module.container_registry.login_server, "latest")
  health_check_path = "/actuator/info"


  # App settings
  app_settings = local.shared_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []
  subnet_id       = module.shared_app_service_snet.id

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "wgq43e_app_service_autoscale" {
  name                = format("%s-autoscale-node-forwarder", local.project)
  resource_group_name = azurerm_resource_group.shared_app_service_rg.name
  location            = azurerm_resource_group.shared_app_service_rg.location
  target_resource_id  = module.shared_app_service.plan_id
  enabled             = var.app_service_autoscale_enabled

  profile {
    name = "default"

    capacity {
      default = 5
      minimum = 1
      maximum = 10
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.shared_app_service.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.shared_app_service.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }
  }
}

# KV placeholder for CERT and KEY certificate
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "certificate_crt_node_forwarder_s" {
  name         = "certificate-crt-node-forwarder"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "certificate_key_node_forwarder_s" {
  name         = "certificate-key-app-service"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

data "azurerm_key_vault_secret" "certificate_crt_node_forwarder" {
  name         = "certificate-crt-app-service"
  key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "certificate_key_node_forwarder" {
  name         = "certificate-key-app-service"
  key_vault_id = data.azurerm_key_vault.kv.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "node_forwarder_subscription_key" {
  count        = var.env_short != "p" ? 1 : 0 # only in DEV and UAT
  name         = "shared-app-service-api-subscription-key"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

