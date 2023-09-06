resource "azurerm_resource_group" "gps_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

module "gps_cosmosdb_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.6.1"
  name                 = "${local.project}-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_gps_cosmosdb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "gps_cosmosdb_account" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v6.4.1"
  name     = "${local.project}-cosmos-account"
  location = var.location
  domain   = var.domain

  resource_group_name = azurerm_resource_group.gps_rg.name
  offer_type          = var.cosmos_gps_db_params.offer_type
  kind                = var.cosmos_gps_db_params.kind

  public_network_access_enabled    = var.cosmos_gps_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.cosmos_gps_db_params.main_geo_location_zone_redundant

  enable_free_tier                             = var.cosmos_gps_db_params.enable_free_tier
  enable_automatic_failover                    = true
  enable_provisioned_throughput_exceeded_alert = false

  capabilities       = var.cosmos_gps_db_params.capabilities
  consistency_policy = var.cosmos_gps_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.cosmos_gps_db_params.additional_geo_locations
  backup_continuous_enabled  = var.cosmos_gps_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.cosmos_gps_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.cosmos_gps_db_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]

  # private endpoint
  private_endpoint_name    = "${local.project}-cosmos-sql-endpoint"
  private_endpoint_enabled = var.cosmos_gps_db_params.private_endpoint_enabled
  subnet_id                = module.gps_cosmosdb_snet.id
  private_dns_zone_ids     = [data.azurerm_private_dns_zone.cosmos.id]

  tags = var.tags
}

# cosmosdb database
module "gps_cosmosdb_database" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database?ref=v6.4.1"
  name                = "db"
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gps_cosmosdb_account.name
}

### Containers
locals {

  gps_cosmosdb_containers = [
    {
      name               = "creditor_institutions",
      partition_key_path = "/fiscalCode",
      autoscale_settings = { max_throughput = 1000 }
    },
    {
      name               = "services",
      partition_key_path = "/transferCategory",
      autoscale_settings = { max_throughput = 1000 }
    },
  ]
}

# cosmosdb container
module "gps_cosmosdb_containers" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v6.4.1"
  for_each = { for c in local.gps_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gps_cosmosdb_account.name
  database_name       = module.gps_cosmosdb_database.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)

  autoscale_settings = contains(var.cosmos_gps_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}

module "gpd_payments_cosmosdb_account" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v7.0.0"
  name     = "${local.project}-payments-cosmos-account"
  location = var.location
  domain   = var.domain

  resource_group_name = azurerm_resource_group.gps_rg.name
  offer_type          = var.cosmos_gpd_payments_db_params.offer_type
  kind                = var.cosmos_gpd_payments_db_params.kind

  public_network_access_enabled    = var.cosmos_gpd_payments_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.cosmos_gpd_payments_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.cosmos_gpd_payments_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.cosmos_gpd_payments_db_params.capabilities
  consistency_policy = var.cosmos_gpd_payments_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.cosmos_gpd_payments_db_params.additional_geo_locations
  backup_continuous_enabled  = var.cosmos_gpd_payments_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.cosmos_gpd_payments_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.cosmos_gpd_payments_db_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]

  # private endpoint
  private_endpoint_enabled   = var.cosmos_gpd_payments_db_params.private_endpoint_enabled
  subnet_id                  = module.gps_cosmosdb_snet.id
  private_dns_zone_sql_ids   = [data.azurerm_private_dns_zone.cosmos.id]
  private_dns_zone_table_ids = [data.azurerm_private_dns_zone.cosmos_table.id]

  tags = var.tags
}

# cosmosdb gpd payments table
resource "azurerm_cosmosdb_table" "payments_receipts_table" {
  name                = "gpdpaymentsreceiptstable"
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gpd_payments_cosmosdb_account.name
  throughput          = !var.cosmos_gpd_payments_db_params.payments_receipts_table.autoscale ? var.cosmos_gpd_payments_db_params.payments_receipts_table.throughput : null
  dynamic "autoscale_settings" {
    for_each = var.cosmos_gpd_payments_db_params.payments_receipts_table.autoscale ? ["dummy"] : []
    content {
      max_throughput = var.cosmos_gpd_payments_db_params.payments_receipts_table.throughput
    }
  }
}
