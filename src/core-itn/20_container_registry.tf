resource "azurerm_resource_group" "acr_ita_rg" {
  name     = "${local.product_ita}-acr-rg"
  location = var.location

  tags = var.tags
}

module "container_registry_ita" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_registry?ref=v8.1.0"

  name                = replace("${local.project}-acr", "-", "")
  resource_group_name = azurerm_resource_group.acr_ita_rg.name
  location            = azurerm_resource_group.acr_ita_rg.location

  sku                           = var.container_registry_sku
  zone_redundancy_enabled       = var.container_registry_zone_redundancy_enabled
  public_network_access_enabled = true
  private_endpoint_enabled      = false

  admin_enabled          = false
  anonymous_pull_enabled = false

  tags = var.tags
}
