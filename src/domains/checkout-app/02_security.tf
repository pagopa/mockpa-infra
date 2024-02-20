data "azurerm_resource_group" "sec_rg" {
  name = format("%s-sec-rg", local.product)
}

data "azurerm_key_vault" "key_vault" {
  name                = format("%s-kv", local.parent_project)
  resource_group_name = data.azurerm_resource_group.sec_rg.name
}

data "azurerm_key_vault_secret" "google_recaptcha_secret" {
  name         = "google-recaptcha-secret"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_checkout_opsgenie_webhook_key" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}