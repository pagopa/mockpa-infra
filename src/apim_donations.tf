##############
## Products ##
##############

module "apim_donations_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.84"

  product_id   = "donations-iuv"
  display_name = "Donations"
  description  = "Donations"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/donations/_base_policy.xml")
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_donations_api" {

  name                = format("%s-api-donations-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Donations"
  versioning_scheme   = "Segment"
}


module "apim_api_donations_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-api-donations-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_donations_product.product_id]
  subscription_required = false
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_donations_api.id
  service_url           = null // no BE


  description  = "donations"
  display_name = "donations pagoPA"
  path         = "donations/api"
  protocols    = ["https"]


  content_format = "openapi"
  content_value = templatefile("./api/donations/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/donations/v1/_base_policy.xml")
}


resource "azurerm_api_management_api_operation_policy" "get_donations" {
  api_name            = format("%s-api-donations-api-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = "getavailabledonations"

  # xml_content = file("./api/donations/v1/donazioni_ucraina.xml")

  xml_content = templatefile("./api/donations/v1/donazioni_ucraina.xml", {
    logo_1 = file("./api/donations/v1/logos/logo1")
    logo_2 = file("./api/donations/v1/logos/logo2")
  })

}
