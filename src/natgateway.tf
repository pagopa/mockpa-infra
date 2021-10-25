module "nat_gw" {
  count  = var.nat_gateway_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//nat_gateway?ref=fix-deprecated-availability_zone"

  name                = format("%s-natgw", local.project)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  public_ips_count    = var.nat_gateway_public_ips
  zone                = "1"
  subnet_ids = [
    module.checkout_function_snet[0].id,
  ]

  tags = var.tags
}
