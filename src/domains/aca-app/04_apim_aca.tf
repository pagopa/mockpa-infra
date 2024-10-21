##############
## Products ##
##############

module "apim_aca_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "aca"
  display_name = "ACA pagoPA"
  description  = "Product for A.C.A. pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

module "apim_gpd_for_aca_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "gpd_for_aca"
  display_name = "GPD for ACA pagoPA"
  description  = "Product GPD for A.C.A. pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#################################################
## API ACA service                          ##
#################################################
locals {
  apim_aca_api = {
    display_name          = "pagoPA - A.C.A. API"
    description           = "API for A.C.A. service"
    path                  = "aca"
    subscription_required = true
    service_url           = null
  }
}

# aca service APIs
resource "azurerm_api_management_api_version_set" "aca_api" {
  name                = format("%s-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_aca_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_aca_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = format("%s-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_aca_product.product_id, module.apim_gpd_for_aca_product.product_id]
  subscription_required = local.apim_aca_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.aca_api.id
  api_version           = "v1"

  description  = local.apim_aca_api.description
  display_name = local.apim_aca_api.display_name
  path         = local.apim_aca_api.path
  protocols    = ["https"]
  service_url  = local.apim_aca_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/aca/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/aca/v1/_base_policy.xml", {
    aca_ingress_hostname = local.aca_hostname
  })
}
