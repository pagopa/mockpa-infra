resource "azurerm_resource_group" "db_rg_2" {
  name     = format("%s-db-rg-2", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_key_vault_secret" "pgres_flex_admin_login_2" {
  name         = "db-administrator-login"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_flex_admin_pwd_2" {
  name         = "db-administrator-login-password"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

# Postgres Flexible Server subnet
module "postgres_flexible_snet_2" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.1.13"
  name                                           = format("%s-pgres-flexible-snet-2", local.project)
  address_prefixes                               = var.cidr_subnet_flex_dbms
  resource_group_name                            = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet.name
  service_endpoints                              = ["Microsoft.Storage"]
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "delegation"
    service_delegation = {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

module "postgres_flexible_server_2" {
  source              = "git::https://github.com/pagopa/azurerm.git//postgres_flexible_server?ref=v2.12.3"
  name                = format("%s-flexible-postgresql-2", local.project)
  location            = azurerm_resource_group.db_rg_2.location
  resource_group_name = azurerm_resource_group.db_rg_2.name

  private_endpoint_enabled    = var.pgres_flex_private_endpoint_enabled
  private_dns_zone_id         = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id         = var.env_short != "d" ? module.postgres_flexible_snet_2.id : null
  high_availability_enabled   = var.pgres_flex_ha_enabled
  pgbouncer_enabled           = var.pgres_flex_pgbouncer_enabled
  diagnostic_settings_enabled = var.pgres_flex_diagnostic_settings_enabled
  administrator_login         = data.azurerm_key_vault_secret.pgres_flex_admin_login_2.value
  administrator_password      = data.azurerm_key_vault_secret.pgres_flex_admin_pwd_2.value

  sku_name                     = var.pgres_flex_params.sku_name
  db_version                   = var.pgres_flex_params.db_version
  storage_mb                   = var.pgres_flex_params.storage_mb
  zone                         = var.pgres_flex_params.zone
  backup_retention_days        = var.pgres_flex_params.backup_retention_days
  geo_redundant_backup_enabled = var.pgres_flex_params.geo_redundant_backup_enabled
  create_mode                  = var.pgres_flex_params.create_mode

  tags = var.tags
}

# Nodo database
resource "azurerm_postgresql_flexible_server_database" "nodo_db_2" {
  name      = var.pgres_flex_nodo_db_name
  server_id = module.postgres_flexible_server_2.id
  collation = "en_US.utf8"
  charset   = "utf8"
}
