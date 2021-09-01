env_short         = "d"
mock_ec_enabled   = true
mock_ec_always_on = true
tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# APIM
apim_notification_sender_email = "info@pagopa.it"
apim_publisher_name            = "PagoPA Centro Stella DEV"
apim_sku                       = "Developer_1" # DEV / UAT : Developer_1 - PROD : Premium_1

lock_enable = true

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_integration_vnet = ["10.230.5.0/24"]
cidr_subnet_apim      = ["10.230.5.0/26"]
cidr_subnet_redis     = ["10.1.132.0/24"]
cidr_vnet = ["10.1.0.0/16"]
