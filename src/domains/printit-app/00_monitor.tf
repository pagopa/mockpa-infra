#
# 🇮🇹 Monitor Italy
#
data "azurerm_resource_group" "monitor_italy_rg" {
  name = var.monitor_italy_resource_group_name
}

data "azurerm_log_analytics_workspace" "log_analytics_italy" {
  name                = var.log_analytics_italy_workspace_name
  resource_group_name = var.log_analytics_italy_workspace_resource_group_name
}

data "azurerm_application_insights" "application_insights_italy" {
  name                = local.monitor_appinsights_italy_name
  resource_group_name = data.azurerm_resource_group.monitor_italy_rg.name
}
