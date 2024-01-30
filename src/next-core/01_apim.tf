# APIM subnet
module "apimv2_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.50.0"
  name                 = "${local.project}-apimv2-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_integration.name
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
  address_prefixes     = var.cidr_subnet_apim

  service_endpoints                              = ["Microsoft.Web"]
}


resource "azurerm_network_security_group" "apim_snet_nsg" {
  name                = "apimv2-snet-nsg"
  location            = var.location
  resource_group_name = data.azurerm_virtual_network.vnet_integration.name
}

resource "azurerm_network_security_rule" "apim_snet_nsg_rules" {
  count = length(var.apim_v2_subnet_nsg_security_rules)

  network_security_group_name = azurerm_network_security_group.apim_snet_nsg.name
  name                        = var.apim_v2_subnet_nsg_security_rules[count.index].name
  resource_group_name         = data.azurerm_resource_group.rg_vnet_integration.name
  priority                    = var.apim_v2_subnet_nsg_security_rules[count.index].priority
  direction                   = var.apim_v2_subnet_nsg_security_rules[count.index].direction
  access                      = var.apim_v2_subnet_nsg_security_rules[count.index].access
  protocol                    = var.apim_v2_subnet_nsg_security_rules[count.index].protocol
  source_port_range           = var.apim_v2_subnet_nsg_security_rules[count.index].source_port_range
  destination_port_range      = var.apim_v2_subnet_nsg_security_rules[count.index].destination_port_range
  source_address_prefix       = var.apim_v2_subnet_nsg_security_rules[count.index].source_address_prefix
  destination_address_prefix  = var.apim_v2_subnet_nsg_security_rules[count.index].destination_address_prefix
}

resource "azurerm_subnet_network_security_group_association" "apim_stv2_snet" {
  subnet_id                 = module.apimv2_snet.id
  network_security_group_id = azurerm_network_security_group.apim_snet_nsg.id
}


resource "azurerm_public_ip" "apim_public_ip" {
  name                = "${local.product}-apim-pip"
  resource_group_name = data.azurerm_resource_group.rg_vnet_integration.name
  location            = data.azurerm_resource_group.rg_vnet_integration.location
  sku                 = "Standard"
  domain_name_label   = "apimpagopa"
  allocation_method   = "Static"

  zones = var.apim_v2_zones

  tags = var.tags
}

locals {
  apim_cert_name_proxy_endpoint   = format("%s-proxy-endpoint-cert", local.project)
  portal_cert_name_proxy_endpoint = format("%s-proxy-endpoint-cert", "portal")

  api_domain        = format("api.%s.%s", var.dns_zone_prefix, var.external_domain)
  prf_domain        = format("api.%s.%s", var.dns_zone_prefix_prf, var.external_domain)
  portal_domain     = format("portal.%s.%s", var.dns_zone_prefix, var.external_domain)
  management_domain = format("management.%s.%s", var.dns_zone_prefix, var.external_domain)
}

module "apimv2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management?ref=v7.50.0"

  subnet_id            = module.apimv2_snet.id
  location             = data.azurerm_resource_group.rg_vnet_integration.location
  name                 = "${local.project}-apim"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_integration.name
  publisher_name       = var.apim_v2_publisher_name
  publisher_email      = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name             = var.apim_v2_sku

  public_ip_address_id = azurerm_public_ip.apim_public_ip.id

  virtual_network_type = "Internal"

  redis_connection_string = var.redis_cache_enabled ? data.azurerm_redis_cache.redis.primary_connection_string : null
  redis_cache_id          = var.redis_cache_enabled ? data.azurerm_redis_cache.redis.id : null

  application_insights = {
    enabled = true
    instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  }
  zones = var.apim_v2_zones



  # This enables the Username and Password Identity Provider
  sign_up_enabled = false

  lock_enable = false

  # sign_up_terms_of_service = {
  #   consent_required = false
  #   enabled          = false
  #   text             = ""
  # }


  xml_content = templatefile("./api/base_policy.tpl", {
    portal-domain         = local.portal_domain
    management-api-domain = local.management_domain
    apim-name             = format("%s-apim", local.project)
  })

  autoscale = var.apim_v2_autoscale

  alerts_enabled = var.apim_v2_alerts_enabled

  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  # metrics docs
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftapimanagementservice
  metric_alerts = {
    capacity = {
      description   = "Apim used capacity is too high"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = [{
        metric_namespace       = "Microsoft.ApiManagement/service"
        metric_name            = "Capacity"
        aggregation            = "Average"
        operator               = "GreaterThan"
        threshold              = 50
        skip_metric_validation = false
        dimension              = []
      }]
      dynamic_criteria = []
    }

    duration = {
      description   = "Apim abnormal response time"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Duration"
        aggregation              = "Average"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension                = []
      }]
    }

    requests_failed = {
      description   = "Apim abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Requests"
        aggregation              = "Total"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension = [{
          name     = "BackendResponseCode"
          operator = "Include"
          values   = ["5xx"]
        }]
      }]
    }
  }

  tags = var.tags

#  depends_on = [
#    azurerm_application_insights.application_insights
#  ]
}
