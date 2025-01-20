##############
## Products ##
##############

module "apim_receipts_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "receipts"
  display_name = "Receipts Service PDF"
  description  = "Servizio per gestire recupero ricevute"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/receipt-service/_base_policy.xml")
}

#################
##    API Biz Events  ##
#################
locals {
  apim_receipts_service_api = {
    display_name          = "Receipts Service PDF"
    description           = "API to handle receipts"
    path                  = "receipts/service"
    subscription_required = true
    service_url           = null
  }

  apim_receipts_helpdesk_api = {
    display_name          = "Receipts Helpdesk PDF"
    description           = "API to handle receipts helpdesk"
    path                  = "receipts/helpdesk"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_receipts_api" {

  name                = format("%s-receipts-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_receipts_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_receipts_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-receipts-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_receipts_product.product_id]
  subscription_required = local.apim_receipts_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_receipts_api.id
  api_version           = "v1"

  description  = local.apim_receipts_service_api.description
  display_name = local.apim_receipts_service_api.display_name
  path         = local.apim_receipts_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_receipts_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/receipt-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/receipt-service/v1/_base_policy.xml", {
    hostname = local.receipts_hostname
  })
}

resource "azurerm_api_management_api_version_set" "api_receipts_helpdesk_api" {

  name                = format("%s-receipts-helpdesk-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_receipts_helpdesk_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_receipts_helpdesk_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-receipts-helpdesk-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_receipts_product.product_id, "technical_support_api"]
  subscription_required = local.apim_receipts_helpdesk_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_receipts_helpdesk_api.id
  api_version           = "v1"

  description  = local.apim_receipts_helpdesk_api.description
  display_name = local.apim_receipts_helpdesk_api.display_name
  path         = local.apim_receipts_helpdesk_api.path
  protocols    = ["https"]
  service_url  = local.apim_receipts_helpdesk_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/receipt-helpdesk/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/receipt-helpdesk/v1/_base_policy.xml", {
    hostname = local.receipts_hostname
  })
}
