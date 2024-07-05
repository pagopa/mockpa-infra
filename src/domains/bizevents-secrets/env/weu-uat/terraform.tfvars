prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "bizevents"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/bizevents-secret"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

input_file = "./secret/weu-uat/configs.json"

enable_iac_pipeline = true

ecommerce_domain = "ecommerce"

pay_wallet_domain = "pay-wallet"