# gpd_rg
resource "azurerm_resource_group" "gpd_rg" {
  name     = "${local.product}-gpd-rg"
  location = var.location

  tags = var.tags
}

module "flows" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.4.1"

  name                            = replace(format("%s-flow-sa", local.product), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.reporting_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.gpd_rg.name
  location                        = var.location
  advanced_threat_protection      = var.reporting_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  enable_low_availability_alert   = false

  blob_delete_retention_days = var.reporting_storage_account.blob_delete_retention_days

  blob_change_feed_enabled = var.reporting_storage_account.backup_enabled
  blob_change_feed_retention_in_days = var.reporting_storage_account.backup_enabled ? var.reporting_storage_account.blob_delete_retention_days : null
  blob_container_delete_retention_days = var.reporting_storage_account.backup_enabled ? var.reporting_storage_account.blob_delete_retention_days : null
  blob_storage_policy = var.reporting_storage_account.backup_enabled ? {
    enable_immutability_policy = false
    blob_restore_policy_days = var.reporting_storage_account.blob_delete_retention_days
  } : null

  tags = var.tags
}

## table#1 storage
resource "azurerm_storage_table" "reporting_organizations_table" {
  name                 = format("%sorgstable", module.flows.name)
  storage_account_name = module.flows.name
}

## table#2 storage
resource "azurerm_storage_table" "reporting_flows_table" {
  name                 = format("%stable", module.flows.name)
  storage_account_name = module.flows.name
}

## queue#1 storage flows
resource "azurerm_storage_queue" "reporting_flows_queue" {
  name                 = format("%squeueflows", module.flows.name)
  storage_account_name = module.flows.name
}

## queue#2 storage organization
resource "azurerm_storage_queue" "reporting_organizations_queue" {
  name                 = format("%squeueorg", module.flows.name)
  storage_account_name = module.flows.name
}

## queue#3 storage flows
resource "azurerm_storage_queue" "reporting_options_queue" {
  name                 = format("%squeueopt", module.flows.name)
  storage_account_name = module.flows.name
}

## blob container flows
resource "azurerm_storage_container" "reporting_flows_container" {
  name                  = format("%sflowscontainer", module.flows.name)
  storage_account_name  = module.flows.name
  container_access_type = "private"
}
