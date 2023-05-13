module "afm_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.7.0"

  name                       = replace(format("%s-sa", local.project), "-", "")
  account_kind               = var.afm_storage_params.kind
  account_tier               = var.afm_storage_params.tier
  account_replication_type   = var.afm_storage_params.account_replication_type
  access_tier                = "Hot"
  blob_versioning_enabled          = true
  resource_group_name        = azurerm_resource_group.afm_rg.name
  location                   = var.location
  advanced_threat_protection = var.afm_storage_params.advanced_threat_protection
  allow_nested_items_to_be_public   = false
  public_network_access_enabled   = var.afm_storage_params.public_network_access_enabled

  blob_delete_retention_days = var.afm_storage_params.retention_days

  tags = var.tags
}

resource "azurerm_storage_table" "issuer_range_table" {
  name                 = format("%sissuerrangetable", module.afm_storage.name)
  storage_account_name = module.afm_storage.name
}
