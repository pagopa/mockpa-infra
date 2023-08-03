##############
## Products ##
##############

module "apim_ecommerce_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.6.0"

  product_id   = "ecommerce"
  display_name = "ecommerce pagoPA"
  description  = "Product for ecommerce pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

##############################
## API transactions service ##
##############################
locals {
  apim_ecommerce_transactions_service_api = {
    display_name          = "ecommerce pagoPA - transactions service API"
    description           = "API to support transactions service"
    path                  = "ecommerce/transactions-service"
    subscription_required = true
    service_url           = null
  }
}

# Transactions service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_transactions_service_api" {
  name                = format("%s-transactions-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_transactions_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_transactions_service_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-transactions-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_transactions_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_transactions_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_transactions_service_api.description
  display_name = local.apim_ecommerce_transactions_service_api.display_name
  path         = local.apim_ecommerce_transactions_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_transactions_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-transactions-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-transactions-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

###########################################
## API transaction auth requests service ##
###########################################
locals {
  apim_ecommerce_transaction_auth_requests_service_api = {
    display_name          = "ecommerce pagoPA - transaction auth requests service API"
    description           = "API to support transaction auth requests service"
    path                  = "ecommerce/transaction-auth-requests-service"
    subscription_required = true
    service_url           = null
  }
}

# Transaction auth request service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_transaction_auth_requests_service_api" {
  name                = format("%s-transaction-auth-requests-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_transaction_auth_requests_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_transaction_auth_requests_service_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-transaction-auth-requests-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_transaction_auth_requests_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_transaction_auth_requests_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_transaction_auth_requests_service_api.description
  display_name = local.apim_ecommerce_transaction_auth_requests_service_api.display_name
  path         = local.apim_ecommerce_transaction_auth_requests_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_transaction_auth_requests_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-transaction-auth-requests-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-transaction-auth-requests-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

#####################################
## API transaction user receipts service ##
#####################################
locals {
  apim_ecommerce_transaction_user_receipts_service_api = {
    display_name          = "ecommerce pagoPA - transaction user receipts service API"
    description           = "API to support Nodo.sendPaymentResult"
    path                  = "ecommerce/transaction-user-receipts-service"
    subscription_required = true
    service_url           = null
  }
}

# Transaction user receipts service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_transaction_user_receipts_service_api" {
  name                = format("%s-transaction-user-receipts-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_transaction_user_receipts_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_transaction_user_receipts_service_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-transaction-user-receipts-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_transaction_user_receipts_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_transaction_user_receipts_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_transaction_user_receipts_service_api.description
  display_name = local.apim_ecommerce_transaction_user_receipts_service_api.display_name
  path         = local.apim_ecommerce_transaction_user_receipts_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_transaction_user_receipts_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-transaction-user-receipts-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-transaction-user-receipts-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

#################################################
## API payment request service                 ##
#################################################
locals {
  apim_ecommerce_payment_requests_service_api = {
    display_name          = "ecommerce pagoPA - payment requests API"
    description           = "API to support payment requests service"
    path                  = "ecommerce/payment-requests-service"
    subscription_required = true
    service_url           = null
  }
}

# Payment requests service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_payment_requests_service_api" {
  name                = format("%s-payment-requests-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_payment_requests_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_payment_requests_service_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-payment-requests-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_payment_requests_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_payment_requests_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_payment_requests_service_api.description
  display_name = local.apim_ecommerce_payment_requests_service_api.display_name
  path         = local.apim_ecommerce_payment_requests_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_payment_requests_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-payment-requests-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-payment-requests-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

#####################################
## API payment methods service ##
#####################################
locals {
  apim_ecommerce_payment_methods_service_api = {
    display_name          = "ecommerce pagoPA - payment methods service API"
    description           = "API to support payment methods in ecommerce"
    path                  = "ecommerce/payment-methods-service"
    subscription_required = true
    service_url           = null
  }
}

# Payment methods service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_payment_methods_service_api" {
  name                = format("%s-payment-methods-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_payment_methods_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_payment_methods_service_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-payment-methods-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_payment_methods_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_payment_methods_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_payment_methods_service_api.description
  display_name = local.apim_ecommerce_payment_methods_service_api.display_name
  path         = local.apim_ecommerce_payment_methods_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_payment_methods_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-payment-methods-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-payment-methods-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

##############################
## API notifications service ##
##############################
locals {
  apim_pagopa_notifications_service_api = {
    display_name          = "pagoPA ecommerce - notifications service API"
    description           = "API to support notifications service"
    path                  = "ecommerce/notifications-service"
    subscription_required = true
    service_url           = null
  }
}

# Notifications service APIs
resource "azurerm_api_management_api_version_set" "pagopa_notifications_service_api" {
  name                = format("%s-notifications-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_notifications_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pagopa_notifications_service_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-notifications-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_pagopa_notifications_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_notifications_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_notifications_service_api.description
  display_name = local.apim_pagopa_notifications_service_api.display_name
  path         = local.apim_pagopa_notifications_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_notifications_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-notifications-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-notifications-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

##############################
## API helpdesk service ##
##############################
locals {
  apim_pagopa_helpdesk_service_api = {
    display_name          = "pagoPA ecommerce - helpdesk service API"
    description           = "API to support helpdesk service"
    path                  = "ecommerce/helpdesk-service"
    subscription_required = true
    service_url           = null
  }
}

# helpdesk service APIs
resource "azurerm_api_management_api_version_set" "pagopa_helpdesk_service_api" {
  name                = format("%s-helpdesk-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_helpdesk_service_api.display_name
  versioning_scheme   = "Segment"
}


#helpdesk assistance api for ecommerce
module "apim_pagopa_helpdesk_service_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-helpdesk-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_pagopa_helpdesk_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_helpdesk_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_helpdesk_service_api.description
  display_name = local.apim_pagopa_helpdesk_service_api.display_name
  path         = local.apim_pagopa_helpdesk_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_helpdesk_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-helpdesk-api/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-helpdesk-api/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}


##############################
## API helpdesk assistance service ##
##############################
locals {
  apim_pagopa_helpdesk_assistance_service_api = {
    display_name          = "pagoPA ecommerce - helpdesk assistance service API"
    description           = "API to support helpdesk assistance"
    path                  = "ecommerce/helpdesk-assistance-service"
    subscription_required = true
    service_url           = null
  }
}

# helpdesk service APIs
resource "azurerm_api_management_api_version_set" "pagopa_helpdesk_assistance_service_api" {
  name                = format("%s-helpdesk-assistance-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_helpdesk_assistance_service_api.display_name
  versioning_scheme   = "Segment"
}


#fetch technical support api product APIM product
data "azurerm_api_management_product" "technical_support_api_product" {
  product_id          = "technical_support_api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}


#helpdesk assistance api for ecommerce
module "apim_pagopa_helpdesk_assistance_service_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-helpdesk-assistance-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [data.azurerm_api_management_product.technical_support_api_product.product_id]
  subscription_required = local.apim_pagopa_helpdesk_assistance_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_helpdesk_assistance_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_helpdesk_assistance_service_api.description
  display_name = local.apim_pagopa_helpdesk_assistance_service_api.display_name
  path         = local.apim_pagopa_helpdesk_assistance_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_helpdesk_assistance_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-helpdesk-assistance-api/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-helpdesk-assistance-api/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}