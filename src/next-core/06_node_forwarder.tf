locals {
  node_forwarder_rg_name = "${local.product}-node-forwarder-rg"
  node_forwarder_app_settings = {
    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY                  = data.azurerm_application_insights.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING           = format("InstrumentationKey=%s", data.azurerm_application_insights.application_insights.instrumentation_key)
    APPINSIGHTS_PROFILERFEATURE_VERSION             = "1.0.0"
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION             = "1.0.0"
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT       = ""
    ApplicationInsightsAgent_EXTENSION_VERSION      = "~3"
    DiagnosticServices_EXTENSION_VERSION            = "~3"
    InstrumentationEngine_EXTENSION_VERSION         = "disabled"
    SnapshotDebugger_EXTENSION_VERSION              = "disabled"
    XDT_MicrosoftApplicationInsights_BaseExtensions = "disabled"
    XDT_MicrosoftApplicationInsights_Mode           = "recommended"
    XDT_MicrosoftApplicationInsights_PreemptSdk     = "disabled"
    TIMEOUT_DELAY                                   = 300
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    WEBSITE_DNS_SERVER                              = "168.63.129.16"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE                 = true
    # Spring Environment
    DEFAULT_LOGGING_LEVEL = var.node_forwarder_logging_level
    APP_LOGGING_LEVEL     = var.node_forwarder_logging_level
    JAVA_OPTS             = "-Djavax.net.debug=ssl:handshake" // mTLS debug

    # Cert configuration
    CERTIFICATE_CRT = data.azurerm_key_vault_secret.certificate_crt_node_forwarder.value
    CERTIFICATE_KEY = data.azurerm_key_vault_secret.certificate_key_node_forwarder.value

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"
    DOCKER_REGISTRY_SERVER_URL      = "https://${data.azurerm_container_registry.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.container_registry.admin_password

    # Connection Pool
    MAX_CONNECTIONS           = 80
    MAX_CONNECTIONS_PER_ROUTE = 40
    CONN_TIMEOUT              = 8

  }


}



module "node_forwarder_ha_snet" {
  source                                        = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.69.1"
  count                                         = var.is_feature_enabled.node_forwarder_ha_enabled ? 1 : 0
  name                                          = "${local.project}-node-forwarder-ha-snet"
  address_prefixes                              = var.node_fw_ha_snet_cidr
  resource_group_name                           = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                          = data.azurerm_virtual_network.vnet_core.name
  private_link_service_network_policies_enabled = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_nat_gateway_association" "nodefw_ha_snet_nat_association" {
  count                                         = var.is_feature_enabled.node_forwarder_ha_enabled ? 1 : 0
  subnet_id      = module.node_forwarder_ha_snet[0].id
  nat_gateway_id = data.azurerm_nat_gateway.nat_gw.id
}


module "node_forwarder_app_service" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v7.69.1"

  count = var.is_feature_enabled.node_forwarder_ha_enabled ? 1 : 0

  vnet_integration    = true
  resource_group_name = "${local.product}-node-forwarder-rg"
  location            = var.location

  # App service plan vars
  plan_name = "${local.project}-plan-node-forwarder-ha"

  # App service plan
  name                = "${local.project}-app-node-forwarder-ha"
  client_cert_enabled = false
  always_on           = var.node_forwarder_always_on
  health_check_path   = "/actuator/info"

  app_settings = local.node_forwarder_app_settings

  docker_image     = "${data.azurerm_container_registry.container_registry.login_server}/pagopanodeforwarder"
  docker_image_tag = "latest"

  allowed_subnets = [data.azurerm_subnet.apim_subnet.id]
  allowed_ips     = []

  sku_name = var.node_forwarder_sku

  subnet_id                    = module.node_forwarder_ha_snet[0].id
  health_check_maxpingfailures = 10

  zone_balancing_enabled = var.node_forwarder_zone_balancing_enabled

  tags = var.tags
}

module "node_forwarder_slot_staging" {
  count = var.env_short == "p" && var.is_feature_enabled.node_forwarder_ha_enabled ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot?ref=v7.60.0"

  # App service plan
  app_service_id   = module.node_forwarder_app_service[0].id
  app_service_name = module.node_forwarder_app_service[0].name

  # App service
  name                = "staging"
  resource_group_name = local.node_forwarder_rg_name
  location            = var.location

  always_on         = true
  health_check_path = "/actuator/info"

  # App settings
  app_settings = local.node_forwarder_app_settings
  docker_image     = "${data.azurerm_container_registry.container_registry.login_server}/pagopanodeforwarder"
  docker_image_tag = "latest"

  allowed_subnets = [data.azurerm_subnet.apim_subnet.id]
  allowed_ips     = []
  subnet_id       = module.node_forwarder_ha_snet[0].id

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "node_forwarder_app_service_autoscale" {
  count               = var.is_feature_enabled.node_forwarder_ha_enabled ? 1 : 0
  name                = "${local.project}-autoscale-node-forwarder-ha"
  resource_group_name = local.node_forwarder_rg_name
  location            = var.location
  target_resource_id  = module.node_forwarder_app_service[0].plan_id
  enabled             = var.node_forwarder_autoscale_enabled

  # default profile on REQUESTs
  profile {
    name = "default"

    capacity {
      default = 5
      minimum = 3
      maximum = 10
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.node_forwarder_app_service[0].id
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
        metric_resource_id       = module.node_forwarder_app_service[0].id
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

    # Supported metrics for Microsoft.Web/sites
    # 👀 https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-sites-metrics
    rule {
      metric_trigger {
        metric_name              = "HttpResponseTime"
        metric_resource_id       = module.node_forwarder_app_service[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3 #sec
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
        metric_name              = "HttpResponseTime"
        metric_resource_id       = module.node_forwarder_app_service[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2 #sec
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




#################################
# Alert on mem or cpu avr
#################################
resource "azurerm_monitor_metric_alert" "app_service_over_cpu_usage" {
  count               = var.env_short == "p" && var.is_feature_enabled.node_forwarder_ha_enabled ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-node-forwarder-ha-cpu-usage-over-80"

  scopes      = [module.node_forwarder_app_service[0].plan_id]
  description = "Forwarder CPU usage greater than 80% - https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-node-forwarder"
  severity    = 3
  frequency   = "PT5M"
  window_size = "PT5M"

  target_resource_type     = "microsoft.web/serverfarms"
  target_resource_location = var.location


  criteria {
    metric_namespace       = "microsoft.web/serverfarms"
    metric_name            = "CpuPercentage"
    aggregation            = "Average"
    operator               = "GreaterThan"
    threshold              = "80"
    skip_metric_validation = false
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "app_service_over_mem_usage" {
  count               = var.env_short == "p" && var.is_feature_enabled.node_forwarder_ha_enabled ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-node-forwarder-ha-mem-usage-over-80"

  scopes      = [module.node_forwarder_app_service[0].plan_id]
  description = "Forwarder MEM usage greater than 80% - https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-node-forwarder"
  severity    = 3
  frequency   = "PT5M"
  window_size = "PT5M"

  target_resource_type     = "microsoft.web/serverfarms"
  target_resource_location = var.location


  criteria {
    metric_namespace       = "microsoft.web/serverfarms"
    metric_name            = "MemoryPercentage"
    aggregation            = "Average"
    operator               = "GreaterThan"
    threshold              = "80"
    skip_metric_validation = false
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id
  }

  tags = var.tags
}


