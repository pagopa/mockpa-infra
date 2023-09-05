prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "shared"
location       = "westeurope"
location_short = "weu"
instance       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/shared"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

# CosmosDb IUV Generator
cosmos_iuvgenerator_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = []
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations          = []
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false

}

# CosmosDb Authorizer
cosmos_authorizer_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = []
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  private_endpoint_enabled      = true
  public_network_access_enabled = false

  additional_geo_locations = []

  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false
}


cidr_subnet_iuvgenerator_cosmosdb = ["10.1.150.0/24"]
cidr_subnet_authorizer_cosmosdb   = ["10.1.168.0/24"]
storage_private_endpoint_enabled  = true

# Taxonomy
cidr_subnet_taxonomy_storage_account = ["10.1.183.0/24"]
taxonomy_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "GZRS"
  blob_versioning_enabled       = true
  advanced_threat_protection    = true
  public_network_access_enabled = true
  blob_delete_retention_days    = 0
  enable_low_availability_alert = true
}
