locals {
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_legacy = "${var.prefix}-${var.env_short}"
  product        = "${var.prefix}-${var.env_short}"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"
  pagopa_apim_snet = "${local.product}-apim-snet"

  function_allowed_subnets = var.enabled_features.apim_v2 ? [data.azurerm_subnet.subnet_apim.id, data.azurerm_subnet.apim_v2_snet.id] : [data.azurerm_subnet.subnet_apim.id]


  # app_insights_ips_west_europe = [
  #   "51.144.56.96/28",
  #   "51.144.56.112/28",
  #   "51.144.56.128/28",
  #   "51.144.56.144/28",
  #   "51.144.56.160/28",
  #   "51.144.56.176/28",
  # ]

  # monitor_action_group_slack_name = "SlackPagoPA"
  # monitor_action_group_email_name = "PagoPA"

  # vnet_name                = "${local.product}-vnet"
  # vnet_resource_group_name = "${local.product}-vnet-rg"

  # acr_name                = replace("${local.product}commonacr", "-", "")
  # acr_resource_group_name = "${local.product}-container-registry-rg"

  # ingress_hostname                      = "${var.location_short}${var.instance}.${var.domain}"
  # internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  # internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  # cosmos_dns_zone_name                = "privatelink.documents.azure.com"
  # cosmos_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  # aks_subnet_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks-snet"
}
