resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

# vnet
module "vnet" {
  source               = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.90"
  name                 = format("%s-vnet", local.project)
  location             = azurerm_resource_group.rg_vnet.location
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  address_space        = var.cidr_vnet
  ddos_protection_plan = var.ddos_protection_plan

  tags = var.tags
}

# vnet integration
module "vnet_integration" {
  source               = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v1.0.90"
  name                 = format("%s-vnet-integration", local.project)
  location             = azurerm_resource_group.rg_vnet.location
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  address_space        = var.cidr_vnet_integration
  ddos_protection_plan = var.ddos_protection_plan

  tags = var.tags
}

## Peering between the vnet(main) and integration vnet
module "vnet_peering" {
  source = "git::https://github.com/pagopa/azurerm.git//virtual_network_peering?ref=vnet-peering-custom-name"

  location = azurerm_resource_group.rg_vnet.location

  source_resource_group_name       = azurerm_resource_group.rg_vnet.name
  source_virtual_network_name      = module.vnet.name
  source_remote_virtual_network_id = module.vnet.id
  source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet to vnet_integration

  target_resource_group_name       = azurerm_resource_group.rg_vnet.name
  target_virtual_network_name      = module.vnet_integration.name
  target_remote_virtual_network_id = module.vnet_integration.id
  target_use_remote_gateways       = false # needed by vnet peering with SIA
  target_peering_custom_name       = "pagopa-${var.env_short}-vnet-to-pagopa-${var.env_short}-vnet-integration"
}

module "route_table_peering_sia" {
  source = "git::https://github.com/pagopa/azurerm.git//route_table?ref=v1.0.90"

  name                          = format("%s-sia-rt", local.project)
  location                      = azurerm_resource_group.rg_vnet.location
  resource_group_name           = azurerm_resource_group.rg_vnet.name
  disable_bgp_route_propagation = false

  subnet_ids = [module.apim_snet.id, module.eventhub_snet[0].id]

  routes = [
    {
      # dev aks nodo oncloud
      name                   = "to-aksingress-outbound-sia-dev-subnet"
      address_prefix         = "10.70.66.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # dev
      name                   = "to-pm-appservice-inbound-sia-dev-subnet"
      address_prefix         = "10.70.70.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # dev
      name                   = "to-pm-appservice-outbound-sia-dev-subnet"
      address_prefix         = "10.70.68.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # uat
      name                   = "to-pm-appservice-inbound-sia-uat-subnet"
      address_prefix         = "10.70.71.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # uat
      name                   = "to-pm-appservice-outbound-sia-uat-subnet"
      address_prefix         = "10.70.72.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # uat
      name                   = "to-pm-db-sia-uat-subnet"
      address_prefix         = "10.70.73.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # uat aks nodo oncloud
      name                   = "to-aksingress-outbound-sia-uat-subnet"
      address_prefix         = "10.70.74.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # prod
      name                   = "to-pm-appservice-outbound-sia-prod-subnet"
      address_prefix         = "10.70.136.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # dev nodo db oncloud
      name                   = "to-nodo-db-oncloud-sia-dev"
      address_prefix         = "10.70.67.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # dev nodo db oncloud
      name                   = "to-nodo-app-oncloud-sia-prod"
      address_prefix         = "10.70.135.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
    {
      # prod nodo db oncloud
      name                   = "to-nodo-db-oncloud-sia-prod"
      address_prefix         = "10.70.139.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.70.249.10"
    },
  ]

  tags = var.tags
}

# subnet acr
module "common_private_endpoint_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.28"
  name                 = format("%s-common-private-endpoint-snet", local.project)
  address_prefixes     = var.cidr_common_private_endpoint_snet
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name

  enforce_private_link_endpoint_network_policies = true
}
