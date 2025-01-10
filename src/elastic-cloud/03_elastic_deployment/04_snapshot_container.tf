resource "azurerm_resource_group" "ec_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_storage_account" "ec_snapshot_sa" {
  name                            = replace(format("%s-sa", local.project), "-", "")
  resource_group_name             = azurerm_resource_group.ec_rg.name
  location                        = azurerm_resource_group.ec_rg.location
  account_tier                    = "Standard"
  account_replication_type        = var.elk_snapshot_sa.replication_type
  allow_nested_items_to_be_public = false

  blob_properties {
    change_feed_enabled = var.elk_snapshot_sa.backup_enabled
    dynamic "container_delete_retention_policy" {
      for_each = var.elk_snapshot_sa.backup_enabled ? [1] : []
      content {
        days = var.elk_snapshot_sa.blob_delete_retention_days
      }

    }
    versioning_enabled = var.elk_snapshot_sa.backup_enabled
    dynamic "delete_retention_policy" {
      for_each = var.elk_snapshot_sa.backup_enabled ? [1] : []
      content {
        days = var.elk_snapshot_sa.blob_delete_retention_days
      }

    }
  }

  tags = var.tags
}

resource "azurerm_storage_container" "snapshot_container" {
  name                  = local.deafult_snapshot_container_name
  storage_account_name  = azurerm_storage_account.ec_snapshot_sa.name
  container_access_type = "private"
}


