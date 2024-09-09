locals {
  aks_api_url = var.env_short == "d" ? data.azurerm_kubernetes_cluster.aks.fqdn : data.azurerm_kubernetes_cluster.aks.private_fqdn
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "aks_apiserver_url" {
  name         = "${local.aks_name}-apiserver-url"
  value        = "https://${local.aks_api_url}:443"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

## Manual secrets

resource "azurerm_key_vault_secret" "application_insights_connection_string" {
  name         = "app-insight-connection-string"
  value        = data.azurerm_application_insights.application_insights_italy.connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "azurerm_key_vault_secret" "tenant_id" {
  name         = "tenant-id"
  value        = data.azurerm_subscription.current.tenant_id
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# Event Hub

resource "azurerm_key_vault_secret" "ehub_notice_complete_jaas_config" {
  name         = "ehub-${var.env_short}-notice-complete-jaas-config"
  value        = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${data.azurerm_eventhub_authorization_rule.notices_evt_complete_authorization_rule.primary_connection_string}\";"
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "api_config_subscription_key" {
  name         = "api-config-sub-key"
  value        = azurerm_api_management_subscription.api_config_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

