data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_resource_group" "rg_vnet" {
  name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}

data "azurerm_subnet" "aks_subnet" {
  name                 = local.aks_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "postgres" {
  count               = var.env_short != "d" ? 1 : 0
  name                = "private.postgres.database.azure.com"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}


data "azurerm_private_dns_zone" "storage" {
  count               = var.env_short != "d" ? 1 : 0
  name                = local.storage_dns_zone_name
  resource_group_name = local.storage_dns_zone_resource_group_name
}

resource "azurerm_private_dns_zone" "adf" {

  name                = "privatelink.datafactory.azure.net"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "adf_vnet" {

  name                  = "${local.project}-adf-private-dns-zone-link"
  resource_group_name   = data.azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.adf.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}

data "azurerm_subnet" "private_endpoint_snet" {
  name                 = "${local.product}-common-private-endpoint-snet"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_subnet" "nodo_re_to_datastore_function_snet" {
  name                 = "${local.project}-nodo-re-to-datastore-fn-snet"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_private_dns_zone" "privatelink_redis_azure_com" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "cosmos" {
  name                = local.cosmos_mongo_dns_zone_name
  resource_group_name = local.cosmos_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "cosmos_nosql" {
  name                = local.cosmos_nosql_dns_zone_name
  resource_group_name = local.cosmos_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_blob_azure_com" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_table_azure_com" {
  name                = local.table_dns_zone_name
  resource_group_name = local.storage_dns_zone_resource_group_name
}

# Azure Storage subnet
module "storage_account_snet" {
  source                                        = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.2.1"
  name                                          = format("%s-storage-account-snet", local.project)
  address_prefixes                              = var.cidr_subnet_storage_account
  resource_group_name                           = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                          = data.azurerm_virtual_network.vnet.name
  service_endpoints                             = ["Microsoft.Storage"]
  private_link_service_network_policies_enabled = var.storage_account_snet_private_link_service_network_policies_enabled
}

# CosmosDB subnet
module "cosmosdb_nodo_re_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.3.1"
  name                 = "${local.project}-cosmosb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_nodo_re
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_link_service_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]
}

#module "nodo_re_cosmosdb_snet" {
#  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.3.1"
#  name                 = "${local.project}-re-cosmosdb-snet"
#  address_prefixes     = var.cidr_subnet_cosmosdb_nosql_nodo_re
#  resource_group_name  = local.vnet_resource_group_name
#  virtual_network_name = local.vnet_name
#
#  private_link_service_network_policies_enabled = true
#
#  service_endpoints = [
#    "Microsoft.Web",
#    "Microsoft.AzureCosmosDB",
#  ]
#}
