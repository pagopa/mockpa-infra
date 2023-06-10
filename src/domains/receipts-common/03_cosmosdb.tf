resource "azurerm_resource_group" "receipts_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

module "receipts_datastore_cosmosdb_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.4.1"
  name                 = "${local.project}-datastore-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_receipts_datastore_cosmosdb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "receipts_datastore_cosmosdb_account" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v6.7.0"
  name                = "${local.project}-ds-cosmos-account"
  location            = var.location
  domain              = var.domain
  resource_group_name = azurerm_resource_group.receipts_rg.name
  offer_type          = var.receipts_datastore_cosmos_db_params.offer_type
  kind                = var.receipts_datastore_cosmos_db_params.kind

  public_network_access_enabled    = var.receipts_datastore_cosmos_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.receipts_datastore_cosmos_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.receipts_datastore_cosmos_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.receipts_datastore_cosmos_db_params.capabilities
  consistency_policy = var.receipts_datastore_cosmos_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.receipts_datastore_cosmos_db_params.additional_geo_locations
  backup_continuous_enabled  = var.receipts_datastore_cosmos_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.receipts_datastore_cosmos_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  # allowed_virtual_network_subnet_ids = var.receipts_datastore_cosmos_db_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]
  allowed_virtual_network_subnet_ids = []

  # private endpoint
  private_endpoint_name    = "${local.project}-ds-cosmos-sql-endpoint"
  private_endpoint_enabled = var.receipts_datastore_cosmos_db_params.private_endpoint_enabled
  subnet_id                = module.receipts_datastore_cosmosdb_snet.id
  private_dns_zone_ids     = [data.azurerm_private_dns_zone.cosmos.id]

  tags = var.tags
}

# cosmosdb database for receipts
module "receipts_datastore_cosmosdb_database" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database?ref=v6.7.0"
  name                = "db"
  resource_group_name = azurerm_resource_group.receipts_rg.name
  account_name        = module.receipts_datastore_cosmosdb_account.name
}

### Containers
locals {
  receipts_datastore_cosmosdb_containers = [
    {
      name               = "receipts",
      partition_key_path = "/eventId",
      default_ttl        = var.receipts_datastore_cosmos_db_params.container_default_ttl
      autoscale_settings = { max_throughput = (var.env_short != "p" ? 6000 : 20000) }
    },
  ]
}

# cosmosdb container for receipts datastore
module "receipts_datastore_cosmosdb_containers" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v6.7.0"
  for_each = { for c in local.receipts_datastore_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.receipts_rg.name
  account_name        = module.receipts_datastore_cosmosdb_account.name
  database_name       = module.receipts_datastore_cosmosdb_database.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.receipts_datastore_cosmos_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}
