##############
## Products ##
##############

module "apim_gps_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "spontaneouspayments"
  display_name = "GPS pagoPA"
  description  = "Prodotto Gestione Posizione Spontanee"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#################
##    API GPS  ##
#################
locals {
  apim_spontaneous_payments_service_api = {
    display_name          = "GPS pagoPA - spontaneous payments service API"
    description           = "API to support spontaneous payments service"
    path                  = "gps/spontaneous-payments-service"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_gps_api" {

  name                = format("%s-spontaneous-payments-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_spontaneous_payments_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_gps_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-spontaneous-payments-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_gps_product.product_id]
  subscription_required = local.apim_spontaneous_payments_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_gps_api.id
  api_version           = "v1"

  description  = local.apim_spontaneous_payments_service_api.description
  display_name = local.apim_spontaneous_payments_service_api.display_name
  path         = local.apim_spontaneous_payments_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_spontaneous_payments_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/spontaneous-payments-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/spontaneous-payments-service/v1/_base_policy.xml", {
    hostname = local.gps_hostname
  })
}
