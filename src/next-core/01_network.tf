#
# Vnet Replica
#
module "vnet_replica" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network?ref=v7.62.0"
  count               = var.geo_replica_enabled ? 1 : 0
  name                = "${local.geo_replica_project}-vnet"
  location            = var.geo_replica_location
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name

  address_space        = var.geo_replica_cidr_vnet
  ddos_protection_plan = var.geo_replica_ddos_protection_plan

  tags = var.tags
}

## Peering between the vnet(main) and replica vnet
module "vnet_peering" {
  source                           = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering?ref=v8.13.0"
  count  = var.geo_replica_enabled ? 1 : 0

  source_resource_group_name       = data.azurerm_resource_group.rg_vnet_core.name
  source_virtual_network_name      = module.vnet_replica[0].name
  source_remote_virtual_network_id = module.vnet_replica[0].id
  source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet core to vnet replica
  source_use_remote_gateways       = true
  source_allow_forwarded_traffic   = true

  target_resource_group_name       = data.azurerm_resource_group.rg_vnet_core.name
  target_virtual_network_name      = data.azurerm_virtual_network.vnet_core.name
  target_remote_virtual_network_id = data.azurerm_virtual_network.vnet_core.id
  target_allow_gateway_transit     = true
  target_allow_forwarded_traffic   = true
}





# RT sia associated to new apim v2 snet
resource "azurerm_subnet_route_table_association" "rt_sia_for_apim_v2" {
  subnet_id      = module.apimv2_snet.id
  route_table_id = data.azurerm_route_table.rt_sia.id
}

# RT sia associated to app gw integration
resource "azurerm_subnet_route_table_association" "rt_sia_for_appgw_integration" {
  subnet_id      = module.integration_appgateway_snet.id
  route_table_id = data.azurerm_route_table.rt_sia.id
}



