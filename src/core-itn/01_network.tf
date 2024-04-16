#
# Vnet italy
#
resource "azurerm_resource_group" "rg_ita_vnet" {
  name     = "${local.product_ita}-vnet-rg"
  location = var.location_ita

  tags = var.tags
}

module "vnet_italy" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network?ref=v7.62.0"
  count  = var.is_feature_enabled.vnet_ita ? 1 : 0

  name                = "${local.product_ita}-vnet"
  location            = var.location_ita
  resource_group_name = azurerm_resource_group.rg_ita_vnet.name

  address_space        = var.cidr_vnet_italy
  ddos_protection_plan = var.vnet_ita_ddos_protection_plan

  tags = var.tags
}

## Peering between the vnet(main) and italy vnet
module "vnet_ita_peering" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering?ref=v7.62.0"
  count  = var.is_feature_enabled.vnet_ita ? 1 : 0

  source_resource_group_name       = azurerm_resource_group.rg_ita_vnet.name
  source_virtual_network_name      = module.vnet_italy[0].name
  source_remote_virtual_network_id = module.vnet_italy[0].id
  source_use_remote_gateways       = false
  source_allow_forwarded_traffic   = true

  target_resource_group_name       = data.azurerm_resource_group.rg_vnet_core.name
  target_virtual_network_name      = data.azurerm_virtual_network.vnet_core.name
  target_remote_virtual_network_id = data.azurerm_virtual_network.vnet_core.id
  target_allow_gateway_transit     = true

}

#
# AKS
#
resource "azurerm_public_ip" "aks_leonardo_public_ip" {
  name                = "${local.product}-itn-${var.env}-aksoutbound-pip"
  resource_group_name = azurerm_resource_group.rg_ita_vnet.name
  location            = azurerm_resource_group.rg_ita_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  zones = [1, 2, 3]

  tags = var.tags
}
