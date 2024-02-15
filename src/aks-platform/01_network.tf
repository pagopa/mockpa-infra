module "aks_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.58.0"

  name                                           = "${local.project}-aks-snet"
  address_prefixes                               = var.aks_cidr_subnet
  resource_group_name                            = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                           = data.azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.EventHub",
    "Microsoft.Storage",
  ]

}

resource "azurerm_public_ip" "aks_outbound" {
  count = var.aks_num_outbound_ips

  name                = format("%s-aksoutbound-pip-%02d", local.project, count.index + 1)
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  sku                 = "Standard"
  allocation_method   = "Static"
  availability_zone   = "Zone-Redundant"

  tags = var.tags
}
