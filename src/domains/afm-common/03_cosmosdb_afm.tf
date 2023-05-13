resource "azurerm_resource_group" "afm_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

module "afm_marketplace_cosmosdb_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.7.0"
  name                 = "${local.project}-marketplace-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_afm_marketplace_cosmosdb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "afm_marketplace_cosmosdb_account" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v6.7.0"

  name     = "${local.project}-marketplace-cosmos-account"
  location = var.location
  domain   = var.domain

  resource_group_name = azurerm_resource_group.afm_rg.name
  offer_type          = var.afm_marketplace_cosmos_db_params.offer_type
  kind                = var.afm_marketplace_cosmos_db_params.kind

  public_network_access_enabled    = var.afm_marketplace_cosmos_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.afm_marketplace_cosmos_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.afm_marketplace_cosmos_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.afm_marketplace_cosmos_db_params.capabilities
  consistency_policy = var.afm_marketplace_cosmos_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.afm_marketplace_cosmos_db_params.additional_geo_locations
  backup_continuous_enabled  = var.afm_marketplace_cosmos_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.afm_marketplace_cosmos_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.afm_marketplace_cosmos_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id, data.azurerm_subnet.apiconfig_subnet.id]

  # private endpoint
  private_endpoint_name    = "${local.project}-marketplace-cosmos-sql-endpoint"
  private_endpoint_enabled = var.afm_marketplace_cosmos_db_params.private_endpoint_enabled
  subnet_id                = module.afm_marketplace_cosmosdb_snet.id
  private_dns_zone_ids     = [data.azurerm_private_dns_zone.cosmos.id]

  tags = var.tags
}

# cosmosdb database for marketplace
module "afm_marketplace_cosmosdb_database" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database?ref=v6.7.0"

  name                = "db"
  resource_group_name = azurerm_resource_group.afm_rg.name
  account_name        = module.afm_marketplace_cosmosdb_account.name
}

### Containers
locals {
  afm_marketplace_cosmosdb_containers = [
    {
      name               = "bundles",
      partition_key_path = "/idPsp",
    },
    {
      name               = "archivedbundles",
      partition_key_path = "/idPsp",
    },
    {
      name               = "cibundles",
      partition_key_path = "/ciFiscalCode",
    },
    {
      name               = "archivedcibundles",
      partition_key_path = "/ciFiscalCode",
    },
    {
      name               = "bundlerequests",
      partition_key_path = "/idPsp",
    },
    {
      name               = "archivedbundlerequests",
      partition_key_path = "/idPsp",
    },
    {
      name               = "bundleoffers",
      partition_key_path = "/ciFiscalCode",
    },
    {
      name               = "archivedbundleoffers",
      partition_key_path = "/ciFiscalCode",
    },
    {
      name               = "validbundles",
      partition_key_path = "/idPsp",
    },
    {
      name               = "touchpoints",
      partition_key_path = "/name"
    },
    {
      name               = "paymenttypes",
      partition_key_path = "/name"
    },
    {
      name               = "cdis",
      partition_key_path = "/idPsp"
    }
  ]
}

# cosmosdb container for marketplace
module "afm_marketplace_cosmosdb_containers" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v6.7.0"

  for_each = { for c in local.afm_marketplace_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.afm_rg.name
  account_name        = module.afm_marketplace_cosmosdb_account.name
  database_name       = module.afm_marketplace_cosmosdb_database.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)

  autoscale_settings = contains(var.afm_marketplace_cosmos_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}
