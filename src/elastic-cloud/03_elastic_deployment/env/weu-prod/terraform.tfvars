env_short       = "p"
env             = "prod"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/elk-monitoring"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

hot_config = {
    size = "100g"
    zone_count = 3
}

warm_config = {
    size = "100g"
    zone_count = 3
}

cold_config = {
    size = "100g"
    zone_count = 3
}

elk_snapshot_sa = {
  blob_versioning_enabled    = true
  blob_delete_retention_days = 30
  backup_enabled             = true
  blob_versioning_enabled    = true
  advanced_threat_protection = true
  replication_type = "GZRS"
}
