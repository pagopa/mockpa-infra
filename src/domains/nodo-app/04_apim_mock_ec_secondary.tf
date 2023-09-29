##############
## Products ##
##############

module "apim_mock_ec_secondary_product" {
  source       = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"
  count        = var.env_short == "d" ? 1 : 0
  product_id   = "mock_ec_secondary"
  display_name = "Mock EC (Secondary) for NDP"
  description  = "Mock EC (Secondary) for NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = file("./api_product/mock-ec-secondary-service/_base_policy.xml")
}

########################
##    Mock EC  NDP    ##
########################
locals {
  apim_mock_ec_secondary_service_api = {
    display_name          = "Mock EC (Secondary) for NDP"
    description           = "API Mock EC (Secondary) for NDP"
    path                  = "mock-ec-secondary-ndp/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_mock_ec_secondary_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-mock-ec-secondary-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_mock_ec_secondary_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_mock_ec_secondary_api_v1" {
  count = var.env_short == "d" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.4.1"

  name                  = format("%s-mock-ec-secondary-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_ec_secondary_product[0].product_id, module.apim_apim_for_node_product.product_id]
  subscription_required = local.apim_mock_ec_secondary_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_mock_ec_secondary_api[0].id
  api_version           = "v1"

  description  = local.apim_mock_ec_secondary_service_api.description
  display_name = local.apim_mock_ec_secondary_service_api.display_name
  path         = local.apim_mock_ec_secondary_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_mock_ec_secondary_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/mock-ec-secondary-service/v1/_mock-ec-secondary.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/mock-ec-secondary-service/v1/_base_policy.xml", {
    hostname = local.nodo_hostname
  })
}
