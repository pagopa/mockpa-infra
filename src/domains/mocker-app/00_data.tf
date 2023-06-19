data "azurerm_resource_group" "rg_api" {
  name = format("%s-api-rg", local.product)
}

data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_key_vault" "mocker_kv" {
  name                = local.mocker_kv
  resource_group_name = local.mocker_kv_rg
}

data "azurerm_key_vault_secret" "mocker_db_user" {
  name         = "db-mocker-user-name"
  key_vault_id = data.azurerm_key_vault.mocker_kv.id
}

data "azurerm_key_vault_secret" "mocker_db_pwd" {
  name         = "db-mocker-user-password"
  key_vault_id = data.azurerm_key_vault.mocker_kv.id
}

data "azurerm_postgresql_server" "postgresql" {
  name                = format("%s-mocker-psql", local.product)
  resource_group_name = format("%s-mocker-rg", local.product)
}

data "azurerm_api_management_group" "group_developers" {
  name                = "developers"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
