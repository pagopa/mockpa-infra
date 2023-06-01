##################
## GPD PAYMENTS ##
##################

# storage
module "payments_receipt_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.11.0"

  name                       = replace(format("%s-payments-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  public_network_access_enabled = false
#   versioning_name            = "versioning"
#   enable_versioning          = var.gpd_payments_versioning
  resource_group_name        = azurerm_resource_group.gps_rg.name
  location                   = var.location
  advanced_threat_protection = var.gpd_payments_advanced_threat_protection
#  allow_blob_public_access   = false

#  blob_restore_policy_days = var.gpd_payments_delete_retention_days

  tags = var.tags
}


## table receipts storage
resource "azurerm_storage_table" "payments_receipts_table" {
  name                 = format("%sreceiptstable", module.payments_receipt_sa.name)
  storage_account_name = module.payments_receipt_sa.name
}
