data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "storage" {
  name                = local.storage_blob_dns_zone_name
  resource_group_name = local.storage_blob_resource_group_name
}

data "azurerm_virtual_network" "vnet_italy" {
  name                = local.vnet_italy_name
  resource_group_name = local.vnet_italy_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_italy" {
  name = local.vnet_italy_resource_group_name
}

#
# Eventhub
#
data "azurerm_private_dns_zone" "eventhub" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = local.msg_resource_group_name
}

data "azurerm_resource_group" "rg_event_private_dns_zone" {
  name = local.msg_resource_group_name
}

resource "azurerm_subnet" "eventhub_observability_snet" {
  name                 = "${local.project_itn}-evh-observability-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes     = var.cidr_subnet_observability_evh
}
