##############################
##    API BackOffice with JWT ##
##############################
locals {
  apim_selfcare_pagopa_api = {
    display_name = "Selfcare Backoffice Product pagoPA"
    description  = "API for Backoffice"
  }
}


module "apim_selfcare_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.7.0"

  product_id   = "selfcare-be"
  display_name = local.apim_selfcare_pagopa_api.display_name
  description  = local.apim_selfcare_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

