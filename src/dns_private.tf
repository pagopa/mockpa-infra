
resource "azurerm_private_dns_zone" "db_nodo_dns_zone" {
  name                = var.private_dns_zone_db_nodo_pagamenti
  resource_group_name = azurerm_resource_group.data.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "db_nodo_dns_zone_virtual_link" {
  name                  = format("%s-db_nodo-private-dns-zone-link", local.project)
  resource_group_name   = azurerm_resource_group.data.name
  private_dns_zone_name = azurerm_private_dns_zone.db_nodo_dns_zone.name
  virtual_network_id    = module.vnet_integration.id

  tags = var.tags
}

resource "azurerm_private_dns_a_record" "private_dns_a_record_db_nodo" {
  name                = "db-nodo-pagamenti"
  zone_name           = azurerm_private_dns_zone.db_nodo_dns_zone.name
  resource_group_name = azurerm_resource_group.data.name
  ttl                 = 60
  records             = var.dns_a_reconds_dbnodo_ips
}

resource "azurerm_private_dns_zone" "privatelink_redis_cache_windows_net" {
  count               = var.redis_private_endpoint_enabled ? 1 : 0
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_redis_cache_windows_net_vnet" {
  count                 = var.redis_private_endpoint_enabled ? 1 : 0
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_redis_cache_windows_net[0].name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = var.tags
}
