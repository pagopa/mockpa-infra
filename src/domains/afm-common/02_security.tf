resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = var.tags
}

module "key_vault" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault?ref=v2.13.1"

  name                       = "${local.product}-${var.domain}-kv"
  location                   = azurerm_resource_group.sec_rg.location
  resource_group_name        = azurerm_resource_group.sec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90

  tags = var.tags
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

# azure devops policy
data "azuread_service_principal" "iac_principal" {
  count        = var.enable_iac_pipeline ? 1 : 0
  display_name = "pagopaspa-pagoPA-iac-${data.azurerm_subscription.current.subscription_id}"
}

resource "azurerm_key_vault_access_policy" "azdevops_iac_policy" {
  count        = var.enable_iac_pipeline ? 1 : 0
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.iac_principal[0].object_id

  secret_permissions      = ["Get", "List", "Set", ]
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]

  storage_permissions = []
}

resource "azurerm_key_vault_secret" "afm_marketplace_cosmos_pkey" {
  name         = "afm-marketplace-${var.env_short}-cosmos-pkey"
  value        = module.afm_marketplace_cosmosdb_account.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = "ai-${var.env_short}-connection-string"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "storage_connection_string" {
  name         = format("afm-%s-sa-connection-string", var.env_short)
  value        = module.afm_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "afm_marketplace_subscription_key" {
  name         = "afm-marketplace-subscription-key"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "afm_calculator_subscription_key" {
  name         = "afm-calculator-api-subscription-key"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

