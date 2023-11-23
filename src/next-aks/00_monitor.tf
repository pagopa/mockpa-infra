data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}



data "azurerm_monitor_action_group" "slack" {
  resource_group_name = local.monitor_rg_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}
