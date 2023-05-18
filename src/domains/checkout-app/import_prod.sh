#!/bin/bash
# Generated with `generate_imports.py`

# module.pagopa_proxy_snet
echo 'Importing module.pagopa_proxy_snet.azurerm_subnet.this'
./terraform.sh import weu-prod 'module.pagopa_proxy_snet.azurerm_subnet.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-p-vnet/subnets/pagopa-p-pagopa-proxy-snet'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service.this'
./terraform.sh import weu-prod 'module.pagopa_proxy_app_service.azurerm_app_service.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-p-app-pagopa-proxy'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service_plan.this[0]'
./terraform.sh import weu-prod 'module.pagopa_proxy_app_service.azurerm_app_service_plan.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Web/serverfarms/pagopa-p-plan-pagopa-proxy'


# module.pagopa_proxy_app_service
echo 'Importing module.pagopa_proxy_app_service.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]'
./terraform.sh import weu-prod 'module.pagopa_proxy_app_service.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-p-app-pagopa-proxy/config/virtualNetwork'


# module.pagopa_proxy_app_service_slot_staging[0]
echo 'Importing module.pagopa_proxy_app_service_slot_staging[0].azurerm_app_service_slot.this'
./terraform.sh import weu-prod 'module.pagopa_proxy_app_service_slot_staging[0].azurerm_app_service_slot.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-p-app-pagopa-proxy/slots/staging'


# module.pagopa_proxy_app_service_slot_staging[0]
echo 'Importing module.pagopa_proxy_app_service_slot_staging[0].azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]'
./terraform.sh import weu-prod 'module.pagopa_proxy_app_service_slot_staging[0].azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Web/sites/pagopa-p-app-pagopa-proxy/slots/staging/config/virtualNetwork'


# resource.azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale
echo 'Importing azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale'
./terraform.sh import weu-prod 'azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Insights/autoscaleSettings/pagopa-p-autoscale-pagopa-proxy'

# module.checkout_function_snet[0]
echo 'Importing module.checkout_function_snet[0].azurerm_subnet.this'
./terraform.sh import weu-prod 'module.checkout_function_snet[0].azurerm_subnet.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-p-vnet/subnets/pagopa-p-checkout-be-snet'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_app_service_plan.this[0]'
./terraform.sh import weu-prod 'module.checkout_function[0].azurerm_app_service_plan.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Web/serverfarms/pagopa-p-plan-fncheckout'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_app_service_virtual_network_swift_connection.this[0]'
./terraform.sh import weu-prod 'module.checkout_function[0].azurerm_app_service_virtual_network_swift_connection.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Web/sites/pagopa-p-fn-checkout/config/virtualNetwork'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].azurerm_function_app.this'
./terraform.sh import weu-prod 'module.checkout_function[0].azurerm_function_app.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Web/sites/pagopa-p-fn-checkout'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].module.storage_account.azurerm_advanced_threat_protection.this'
./terraform.sh import weu-prod 'module.checkout_function[0].module.storage_account.azurerm_advanced_threat_protection.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Storage/storageAccounts/pagopapstfncheckout/providers/Microsoft.Security/advancedThreatProtectionSettings/current'


# module.checkout_function[0]
echo 'Importing module.checkout_function[0].module.storage_account.azurerm_storage_account.this'
./terraform.sh import weu-prod 'module.checkout_function[0].module.storage_account.azurerm_storage_account.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Storage/storageAccounts/pagopapstfncheckout'


# resource.azurerm_monitor_autoscale_setting.checkout_function[0]
echo 'Importing azurerm_monitor_autoscale_setting.checkout_function[0]'
./terraform.sh import weu-prod 'azurerm_monitor_autoscale_setting.checkout_function[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Insights/autoscaleSettings/pagopa-p-fn-checkout-autoscale'


# resource.azurerm_monitor_scheduled_query_rules_alert.checkout_availability[0]
echo 'Importing azurerm_monitor_scheduled_query_rules_alert.checkout_availability[0]'
./terraform.sh import weu-prod 'azurerm_monitor_scheduled_query_rules_alert.checkout_availability[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-checkout-be-rg/providers/Microsoft.Insights/scheduledQueryRules/pagopa-p-fn-checkout-availability-alert'


# resource.azurerm_monitor_metric_alert.checkout_fn_5xx[0]
echo 'Importing azurerm_monitor_metric_alert.checkout_fn_5xx[0]'
./terraform.sh import weu-prod 'azurerm_monitor_metric_alert.checkout_fn_5xx[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-monitor-rg/providers/Microsoft.Insights/metricAlerts/pagopa-p-fn-checkout-5xx'


echo 'Import executed succesfully on prod environment! ⚡'
