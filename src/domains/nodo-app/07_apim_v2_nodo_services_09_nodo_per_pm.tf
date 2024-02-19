######################
## Nodo per PM API  ##
######################
locals {
  apim_nodo_per_pm_api = {
    display_name          = "Nodo per Payment Manager API"
    description           = "API to support Payment Manager"
    path                  = "nodo/nodo-per-pm"
    subscription_required = var.nodo_pagamenti_subkey_required
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pm_api" {

  name                = format("%s-nodo-per-pm-api", local.project)
  resource_group_name = local.pagopa_apim_v2_rg
  api_management_name = local.pagopa_apim_v2_name
  display_name        = local.apim_nodo_per_pm_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_nodo_per_pm_api_v1" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.60.0"

  name                  = format("%s-nodo-per-pm-api", local.project)
  api_management_name   = local.pagopa_apim_v2_name
  resource_group_name   = local.pagopa_apim_v2_rg
  subscription_required = local.apim_nodo_per_pm_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api.id
  api_version           = "v1"
  service_url           = local.apim_nodo_per_pm_api.service_url

  description  = local.apim_nodo_per_pm_api.description
  display_name = local.apim_nodo_per_pm_api.display_name
  path         = local.apim_nodo_per_pm_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./apim_v2/api/nodopagamenti_api/nodoPerPM/v1/_swagger.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_nodo_dei_pagamenti_product.product_id
  })

  xml_content = templatefile("./apim_v2/api/nodopagamenti_api/nodoPerPM/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}

resource "azurerm_api_management_api_operation_policy" "close_payment_api_v1" {
  api_name            = format("%s-nodo-per-pm-api-v1", local.project)
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg
  operation_id        = "closePayment"
  xml_content = templatefile("./apim_v2/api/nodopagamenti_api/nodoPerPM/v1/_add_v1_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}

resource "azurerm_api_management_api_operation_policy" "parked_list_api_v1" {
  api_name            = format("%s-nodo-per-pm-api-v1", local.project)
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg
  operation_id        = "parkedList"
  xml_content = templatefile("./apim_v2/api/nodopagamenti_api/nodoPerPM/v1/_add_v1_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}

module "apim_nodo_per_pm_api_v2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.60.0"

  name                  = format("%s-nodo-per-pm-api", local.project)
  api_management_name   = local.pagopa_apim_v2_name
  resource_group_name   = local.pagopa_apim_v2_rg
  subscription_required = local.apim_nodo_per_pm_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api.id
  api_version           = "v2"
  service_url           = local.apim_nodo_per_pm_api.service_url

  description  = local.apim_nodo_per_pm_api.description
  display_name = local.apim_nodo_per_pm_api.display_name
  path         = local.apim_nodo_per_pm_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./apim_v2/api/nodopagamenti_api/nodoPerPM/v2/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./apim_v2/api/nodopagamenti_api/nodoPerPM/v2/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}
