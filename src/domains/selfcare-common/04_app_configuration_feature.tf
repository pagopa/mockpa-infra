resource "azurerm_app_configuration" "selfcare_appconf" {
  name                = "${local.product}-${var.domain}-appconfiguration"
  resource_group_name = azurerm_resource_group.bopagopa_rg.name
  location            = azurerm_resource_group.bopagopa_rg.location
  sku                 = "standard"
}


resource "azurerm_role_assignment" "selfcare_appconf_dataowner" {
  scope                = azurerm_app_configuration.selfcare_appconf.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "selfcare_appconf_dataowner_sp" {
  scope                = azurerm_app_configuration.selfcare_appconf.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = azuread_service_principal.selfcare.object_id
}

resource "azurerm_app_configuration_feature" "maintenance_banner_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the banner"
  name                   = "maintenance-banner"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}

resource "azurerm_app_configuration_feature" "maintenance_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the Maintenance Page"
  name                   = "maintenance"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}

resource "azurerm_app_configuration_feature" "is_operation_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the operation role"
  name                   = "isOperator"
  enabled                = true
  targeting_filter {
    default_rollout_percentage = 0
    groups {
      name               = "@pagopa.it"
      rollout_percentage = 100
    }
  }

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}

resource "azurerm_app_configuration_feature" "commission_bundles_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the commission bundles"
  name                   = "commission-bundles"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}

resource "azurerm_app_configuration_feature" "commission_bundles_private_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the commission bundles of type PRIVATE"
  name                   = "commission-bundles-private"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}

resource "azurerm_app_configuration_feature" "commission_bundles_public_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the commission bundles of type PUBLIC"
  name                   = "commission-bundles-public"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}

resource "azurerm_app_configuration_feature" "delegations_list_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the credit institution's delegations' page"
  name                   = "delegations-list"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}

resource "azurerm_app_configuration_feature" "payments_receipts_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the payments receipts' page"
  name                   = "payments-receipts"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}

resource "azurerm_app_configuration_feature" "test_stations_flag" {
  configuration_store_id = azurerm_app_configuration.selfcare_appconf.id
  description            = "It enables the station testing"
  name                   = "test-stations"
  enabled                = false

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }
}
