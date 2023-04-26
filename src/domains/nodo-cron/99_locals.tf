locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = var.location_short != "neu" ? "${var.prefix}-${var.env_short}" : "${var.prefix}-${var.env_short}-${var.location_short}"
  product_noenv = "${var.prefix}-${var.env_short}"

  aks_name_for_dr = var.location_short != "neu" ? "${local.product}-${var.location_short}-${var.instance}" : "${local.product}-${var.instance}"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
  monitor_appinsights_name        = "${local.product}-appinsights"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  aks_name                = "${local.aks_name_for_dr}-aks"
  aks_resource_group_name = "${local.aks_name_for_dr}-aks-rg"
  aks_subnet_name         = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks-snet"

  ingress_hostname       = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name = "${var.dns_zone_internal_prefix}.${var.external_domain}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  nodo_hostname = "${var.location_short}${var.env}.${var.domain}.internal.${var.env}.platform.pagopa.it"

}
