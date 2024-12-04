#
## Postgres Flexible Server subnet
module "postgres_flexible_snet_replica" {
  count                                         = var.geo_replica_enabled ? 1 : 0
  source                                        = "./.terraform/modules/__v3__/subnet"
  name                                          = "${local.project_replica}-pgres-flexible-snet"
  address_prefixes                              = var.geo_replica_cidr_subnet_postgresql
  resource_group_name                           = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                          = data.azurerm_virtual_network.vnet_replica[0].name
  service_endpoints                             = ["Microsoft.Storage"]
  private_link_service_network_policies_enabled = true

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



module "postgresql_gpd_replica_db" {
  source = "./.terraform/modules/__v3__/postgres_flexible_server_replica"
  count  = var.geo_replica_enabled ? 1 : 0

  name                = "${local.project_replica}-pgflex"
  resource_group_name = azurerm_resource_group.flex_data[0].name
  location            = var.location_replica

  private_dns_zone_id      = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id      = module.postgres_flexible_snet_replica[0].id
  private_endpoint_enabled = var.pgres_flex_params.private_endpoint_enabled

  sku_name = var.pgres_flex_params.sku_name

  high_availability_enabled = false
  pgbouncer_enabled         = var.pgres_flex_params.pgbouncer_enabled

  source_server_id = module.postgres_flexible_server_private[0].id # NEWGPD-DB : DEPRECATED switch to new istance postgres_flexible_server_private_db

  diagnostic_settings_enabled = false

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  zone                       = 2
  tags                       = var.tags
}

resource "null_resource" "virtual_endpoint" {
  count = var.geo_replica_enabled ? 1 : 0
  triggers = {
    rg_name             = azurerm_resource_group.flex_data[0].name
    primary_server_name = module.postgres_flexible_server_private[0].name # NEWGPD-DB : DEPRECATED switch to new istance postgres_flexible_server_private_db
    ve_name             = "${local.project}-pgflex-ve"
    member_name         = module.postgresql_gpd_replica_db[0].name
  }

  provisioner "local-exec" {
    command = <<EOT
    az postgres flexible-server virtual-endpoint create --resource-group ${self.triggers.rg_name} --server-name ${self.triggers.primary_server_name} --name ${self.triggers.ve_name} --endpoint-type ReadWrite --members ${self.triggers.member_name}
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
    az postgres flexible-server virtual-endpoint delete --resource-group ${self.triggers.rg_name} --server-name ${self.triggers.primary_server_name} --name ${self.triggers.ve_name} --yes
    EOT
  }
}

resource "azurerm_private_dns_cname_record" "cname_record" {
  count               = var.geo_replica_enabled && var.pgres_flex_params.enable_private_dns_registration_virtual_endpoint ? 1 : 0
  name                = "gpd-db"
  zone_name           = "${var.env_short}.internal.postgresql.pagopa.it"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = 300
  record              = "${null_resource.virtual_endpoint[0].triggers.ve_name}.writer.postgres.database.azure.com"
}

