##############
## Products ##
##############

module "apim_pdf-engine_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.6.0"

  product_id   = "pdf-engine"
  display_name = "PDF Engine pagoPA"
  description  = "Prodotto PDF Engine"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#########################
##  API PDF ENGINE  ##
#########################
locals {
  apim_pdf-engine_service_api = {
    display_name          = "PDF Engine Service pagoPA - API"
    description           = "API to support PDF generator service"
    path                  = "shared/pdf-engine"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_pdf-engine_api" {

  name                = format("%s-pdf-engine-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pdf-engine_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_pdf-engine_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-pdf-engine-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_pdf-engine_product.product_id]
  subscription_required = local.apim_pdf-engine_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_pdf-engine_api.id
  api_version           = "v1"

  description  = local.apim_pdf-engine_service_api.description
  display_name = local.apim_pdf-engine_service_api.display_name
  path         = local.apim_pdf-engine_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pdf-engine_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/pdf-engine/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/pdf-engine/v1/_base_policy.xml", {
    hostname = local.shared_hostname
  })
}
