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
