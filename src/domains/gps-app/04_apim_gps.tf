##############
## Products ##
##############

module "apim_gps_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "spontaneouspayments"
  display_name = "GPS pagoPA"
  description  = "Prodotto Gestione Posizione Spontanee"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy_no_forbid.xml")
}

#################
##    API GPS  ##
#################

#################
# Depreacted ⚠️⚠️⚠️⚠️⚠️⚠️⚠️ see here https://github.com/pagopa/pagopa-spontaneous-payments/blob/378d08505a12e1dbd83d69c2ea987a2a3ee475a1/infra/04_apim_api.tf#L4
#################

locals {
  apim_spontaneous_payments_service_api = {
    display_name          = "GPS pagoPA - spontaneous payments service API"
    description           = "API to support spontaneous payments service"
    path                  = "gps/spontaneous-payments-service"
    subscription_required = false
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
  source = "./.terraform/modules/__v3__/api_management_api"

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
