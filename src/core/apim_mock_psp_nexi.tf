##############
## Products ##
##############

module "apim_mock_psp_service_product" {
  count  = var.mock_psp_service_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-mock-psp-service"
  display_name = "product-mock-psp-service"
  description  = "product-mock-psp-service"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mockpspservice_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "mock_psp_service_api" {
  count = var.mock_psp_service_enabled ? 1 : 0

  name                = format("%s-mock-psp-service-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Mock PSP Service API"
  versioning_scheme   = "Segment"
}

module "apim_mock_psp_service_api" {
  count  = var.mock_psp_service_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-mock-psp-service-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_mock_psp_service_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.mock_psp_service_api[0].id
  api_version    = "v1"

  description  = "API of Mock PSP Service"
  display_name = "Mock PSP Service API"
  path         = "mock-psp-service/api"
  protocols    = ["https"]

  service_url = null

  content_value = templatefile("./api/mockpspservice_api/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/mockpspservice_api/v1/_base_policy.xml", {
    mock_base_path = "/pspmock-sit/servizi/MockPSP"
  })
}

#############################
## Mock PSP Nexi secondary ##
#############################

module "apim_mock_psp_service_product_secondary" {
  count  = var.mock_psp_service_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-secondary-mock-psp-service"
  display_name = "product-secondary-mock-psp-service"
  description  = "product-secondary-mock-psp-service"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mockpspservice_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "mock_psp_service_api_secondary" {
  count = var.mock_psp_service_enabled ? 1 : 0

  name                = format("%s-secondary-mock-psp-service-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Secondary Mock PSP Service API"
  versioning_scheme   = "Segment"
}

module "apim_mock_psp_service_api_secondary" {
  count  = var.mock_psp_service_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-secondary-mock-psp-service-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_mock_psp_service_product_secondary[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.mock_psp_service_api_secondary[0].id
  api_version    = "v1"

  description  = "Secondary API of Mock PSP Service"
  display_name = "Secondary Mock PSP Service API"
  path         = "secondary-mock-psp-service/api"
  protocols    = ["https"]

  service_url = null

  content_value = templatefile("./api/mockpspservice_api/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/mockpspservice_api/v1/_base_policy.xml", {
    mock_base_path = "/psp-sec-mock-sit/psp-sec-mock"
  })
}