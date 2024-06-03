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

  monitor_appinsights_name           = "${local.product}-appinsights"
  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"

  vnet_name                = "${local.product}-vnet"
  vnet_integration_name    = "${local.product}-vnet-integration"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"

  ingress_hostname       = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name = "${var.dns_zone_internal_prefix}.${var.external_domain}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"

  # apim
  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  apim_nodo_per_pa_api = {
    display_name          = "Nodo per PA WS"
    description           = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
    path                  = "nodo/nodo-per-pa"
    subscription_required = var.nodo_pagamenti_subkey_required
    service_url           = null
  }

  apim_snet = "${local.product}-apim-snet"

  fdr_hostname = var.env == "prod" ? "${var.location_short}${var.env}.${var.domain}.internal.platform.pagopa.it" : "${var.location_short}${var.env}.${var.domain}.internal.${var.env}.platform.pagopa.it"

  # TODO fix the following uing fdr_hostname
  hostname                    = var.env == "prod" ? "weuprod.fdr.internal.platform.pagopa.it" : "weu${var.env}.fdr.internal.${var.env}.platform.pagopa.it"
  hostnameAzFunctionXmlToJson = var.env == "prod" ? "pagopa-weu-fdr-xml-to-json-fn.azurewebsites.net" : "pagopa-${var.env_short}-weu-fdr-xml-to-json-fn.azurewebsites.net"
  hostnameAzFunctionJsonToXml = var.env == "prod" ? "pagopa-weu-fdr-json-to-xml-fn.azurewebsites.net" : "pagopa-${var.env_short}-weu-fdr-json-to-xml-fn.azurewebsites.net"

  product_id            = "fdr"
  display_name          = "Flussi di rendicontazione"
  description           = "Manage FDR ( aka \"Flussi di Rendicontazione\" ) exchanged between PSP and EC"
  subscription_required = true

  path        = "fdr"
  service_url = null

  pagopa_tenant_id = data.azurerm_client_config.current.tenant_id


  function_allowed_subnets = var.enabled_features.apim_v2 ? [data.azurerm_subnet.apim_snet.id, data.azurerm_subnet.apim_v2_snet.id] : [data.azurerm_subnet.apim_snet.id]


}

