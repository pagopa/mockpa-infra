module "authorizer_cosmosdb_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                 = "${local.project}-auth-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_authorizer_cosmosdb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage"
  ]
}

module "authorizer_cosmosdb_account" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.1.18"
  name     = "${local.project}-auth-cosmos-account"
  location = var.location

  resource_group_name = azurerm_resource_group.shared_rg.name
  offer_type          = var.cosmos_authorizer_db_params.offer_type
  kind                = var.cosmos_authorizer_db_params.kind
  //mongo_server_version = var.cosmos_authorizer_db_params.server_version

  public_network_access_enabled    = var.cosmos_authorizer_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.cosmos_authorizer_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.cosmos_authorizer_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.cosmos_authorizer_db_params.capabilities
  consistency_policy = var.cosmos_authorizer_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.cosmos_authorizer_db_params.additional_geo_locations
  backup_continuous_enabled  = var.cosmos_authorizer_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.cosmos_authorizer_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.cosmos_authorizer_db_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]

  # private endpoint
  private_endpoint_name    = "${local.project}-auth-cosmos-endpoint"
  private_endpoint_enabled = var.cosmos_authorizer_db_params.private_endpoint_enabled
  subnet_id                = module.authorizer_cosmosdb_snet.id
  private_dns_zone_ids     = [data.azurerm_private_dns_zone.cosmos.id]

  tags = var.tags
}

module "authorizer_cosmosdb_database" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.1.18"

  name                = "authorizer"
  resource_group_name = azurerm_resource_group.shared_rg.name
  account_name        = module.authorizer_cosmosdb_account.name
}

resource "azurerm_cosmosdb_sql_container" "authorizer_cosmosdb_container" {

  name                = "skeydomains"
  database_name       = module.authorizer_cosmosdb_database.name
  partition_key_path  = "/domain"
  resource_group_name = azurerm_resource_group.shared_rg.name
  account_name        = module.authorizer_cosmosdb_account.name

  unique_key {
    paths   = ["/domain", "/subkey"]
  }
}

