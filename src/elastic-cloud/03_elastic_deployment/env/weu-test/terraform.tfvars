env_short       = "t"
env             = "test"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Test"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/elastic-cloud/03_elastic_deployment"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}



hot_config = {
    size = "4g"
    zone_count = 2
}

warm_config = null
cold_config = null
