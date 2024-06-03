locals {
  project = "${var.prefix}-${var.env_short}"

  apim_x_node_product_id = "apim_for_node"

  soap_basepath_nodo_postgres_pagopa = "nodo"

  azdo_managed_identity_name = "${var.env}-pagopa"

  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
  azdo_iac_managed_identities   = toset(["azdo-${var.env}-pagopa-iac-deploy", "azdo-${var.env}-pagopa-iac-plan"])


  pagopa_apim_v2_name = "${local.project}-${var.location_short}-core-apim-v2"
  pagopa_apim_v2_subnet_name = "${local.project}-${var.location_short}-core-apimv2-snet"
  pagopa_apim_v2_rg   = "${local.project}-api-rg"

  pagopa_apim_migrated_name = "${local.project}-apim"
  pagopa_apim_migrated_rg   = "${local.project}-api-rg"

  vnet_ita_name                = "pagopa-${var.env_short}-itn-vnet"
  vnet_ita_resource_group_name = "pagopa-${var.env_short}-itn-vnet-rg"

  function_allowed_subnets = var.enabled_features.apim_v2_subnet ? [module.apim_snet.id, data.azurerm_subnet.apim_v2_subnet[0].id] : [module.apim_snet.id]

}
