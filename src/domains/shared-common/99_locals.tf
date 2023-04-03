locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

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

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  ingress_hostname                      = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  cosmos_dns_zone_name                = "privatelink.documents.azure.com"
  cosmos_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  iuvgenerator_cosmosdb_tables = [
    {
      name       = "iuvs",
      throughput = 400
    },
  ]

  authorizer_cosmosdb_tables = [
    {
      name       = "subkeys",
      throughput = 400
    },
  ]

  aks_name        = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_subnet_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks-snet"

  storage_queue_dns_zone_name          = "privatelink.queue.core.windows.net"
  storage_dns_zone_resource_group_name = "${local.product}-vnet-rg"
}
