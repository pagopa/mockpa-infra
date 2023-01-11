##############
## Products ##
##############

module "apim_checkout_ec_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "checkout-ec"
  display_name = "checkout pagoPA for ECs"
  description  = "Product for checkout pagoPA for ECs"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/checkout/_base_policy.xml")
}

locals {
  apim_checkout_ec_api = {
    # params for all api versions
    display_name          = "Checkout - EC API"
    description           = "Checkout API for EC"
    path                  = "checkout/ec"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "checkout_ec_api_v1" {
  name                = "${local.project}-checkout-ec-api"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_checkout_ec_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_ec_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = "${local.project}-checkout-ec-api"
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_ec_product[0].product_id]
  subscription_required = local.apim_checkout_ec_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_ec_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_checkout_ec_api.service_url

  description  = local.apim_checkout_ec_api.description
  display_name = local.apim_checkout_ec_api.display_name
  path         = local.apim_checkout_ec_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_ec/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/checkout/checkout_ec/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = var.ecommerce_ingress_hostname,
  })
}
