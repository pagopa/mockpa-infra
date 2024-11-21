# checkout-app

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.33.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | 63f6181a6f3a51707a2ab4795bdbed2d888c708b |
| <a name="module_apim_checkout_auth_product"></a> [apim\_checkout\_auth\_product](#module\_apim\_checkout\_auth\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_checkout_carts_auth"></a> [apim\_checkout\_carts\_auth](#module\_apim\_checkout\_carts\_auth) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_checkout_carts_auth_v1"></a> [apim\_checkout\_carts\_auth\_v1](#module\_apim\_checkout\_carts\_auth\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_checkout_ec_api_v1"></a> [apim\_checkout\_ec\_api\_v1](#module\_apim\_checkout\_ec\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_checkout_ec_product"></a> [apim\_checkout\_ec\_product](#module\_apim\_checkout\_ec\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_checkout_ecommerce_api_v1"></a> [apim\_checkout\_ecommerce\_api\_v1](#module\_apim\_checkout\_ecommerce\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_checkout_payment_activations_api_auth_v1"></a> [apim\_checkout\_payment\_activations\_api\_auth\_v1](#module\_apim\_checkout\_payment\_activations\_api\_auth\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_checkout_payment_activations_api_auth_v2"></a> [apim\_checkout\_payment\_activations\_api\_auth\_v2](#module\_apim\_checkout\_payment\_activations\_api\_auth\_v2) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_checkout_payment_activations_api_v1"></a> [apim\_checkout\_payment\_activations\_api\_v1](#module\_apim\_checkout\_payment\_activations\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_apim_checkout_product"></a> [apim\_checkout\_product](#module\_apim\_checkout\_product) | ./.terraform/modules/__v3__/api_management_product | n/a |
| <a name="module_apim_checkout_transactions_api_v1"></a> [apim\_checkout\_transactions\_api\_v1](#module\_apim\_checkout\_transactions\_api\_v1) | ./.terraform/modules/__v3__/api_management_api | n/a |
| <a name="module_checkout_cdn"></a> [checkout\_cdn](#module\_checkout\_cdn) | ./.terraform/modules/__v3__/cdn | n/a |
| <a name="module_checkout_function"></a> [checkout\_function](#module\_checkout\_function) | ./.terraform/modules/__v3__/function_app | n/a |
| <a name="module_checkout_function_snet"></a> [checkout\_function\_snet](#module\_checkout\_function\_snet) | ./.terraform/modules/__v3__/subnet | n/a |
| <a name="module_pagopa_proxy_app_service"></a> [pagopa\_proxy\_app\_service](#module\_pagopa\_proxy\_app\_service) | ./.terraform/modules/__v3__/app_service | n/a |
| <a name="module_pagopa_proxy_app_service_ha"></a> [pagopa\_proxy\_app\_service\_ha](#module\_pagopa\_proxy\_app\_service\_ha) | ./.terraform/modules/__v3__/app_service | n/a |
| <a name="module_pagopa_proxy_app_service_slot_staging"></a> [pagopa\_proxy\_app\_service\_slot\_staging](#module\_pagopa\_proxy\_app\_service\_slot\_staging) | ./.terraform/modules/__v3__/app_service_slot | n/a |
| <a name="module_pagopa_proxy_app_service_slot_staging_ha"></a> [pagopa\_proxy\_app\_service\_slot\_staging\_ha](#module\_pagopa\_proxy\_app\_service\_slot\_staging\_ha) | ./.terraform/modules/__v3__/app_service_slot | n/a |
| <a name="module_pagopa_proxy_snet"></a> [pagopa\_proxy\_snet](#module\_pagopa\_proxy\_snet) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.76.1 |
| <a name="module_pagopa_proxy_snet_ha"></a> [pagopa\_proxy\_snet\_ha](#module\_pagopa\_proxy\_snet\_ha) | git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet | v7.76.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api.apim_cd_info_wisp_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_operation_policy.activate_payment_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_payment_info_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.get_payment_request_info_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_operation_policy.transaction_authorization_request](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_policy.apim_cd_info_wisp_policy_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |
| [azurerm_api_management_api_version_set.cd_info_wisp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_carts_auth_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_ec_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_ecommerce_api_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_payment_activations_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_payment_activations_auth_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_api_version_set.checkout_transactions_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_version_set) | resource |
| [azurerm_api_management_named_value.pagopa_appservice_proxy_url_value](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_product_api.apim_cd_info_wisp_product_v1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_api_management_product_api.apim_cd_info_wisp_product_v1_apim_for_node](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_api) | resource |
| [azurerm_application_insights_web_test.checkout_fe_web_test](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_web_test) | resource |
| [azurerm_monitor_autoscale_setting.checkout_function](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_autoscale_setting.pagopa_proxy_app_service_autoscale_ha](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_monitor_metric_alert.checkout_fn_5xx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.checkout_availability](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azurerm_resource_group.checkout_be_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.checkout_fe_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_dns_zone.checkout_public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.google_recaptcha_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pagopaproxy_node_clients_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.opsgenie](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_action_group) | data source |
| [azurerm_redis_cache.pagopa_proxy_redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/redis_cache) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.pagopa_proxy_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.azdoa_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.pagopa_proxy_redis_snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_apim_logger_resource_id"></a> [apim\_logger\_resource\_id](#input\_apim\_logger\_resource\_id) | Resource id for the APIM logger | `string` | `null` | no |
| <a name="input_checkout_cdn_storage_replication_type"></a> [checkout\_cdn\_storage\_replication\_type](#input\_checkout\_cdn\_storage\_replication\_type) | (Optional) Checkout cnd storage replication type | `string` | `"GRS"` | no |
| <a name="input_checkout_enabled"></a> [checkout\_enabled](#input\_checkout\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_checkout_function_always_on"></a> [checkout\_function\_always\_on](#input\_checkout\_function\_always\_on) | Always on property | `bool` | `false` | no |
| <a name="input_checkout_function_autoscale_default"></a> [checkout\_function\_autoscale\_default](#input\_checkout\_function\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `1` | no |
| <a name="input_checkout_function_autoscale_maximum"></a> [checkout\_function\_autoscale\_maximum](#input\_checkout\_function\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `3` | no |
| <a name="input_checkout_function_autoscale_minimum"></a> [checkout\_function\_autoscale\_minimum](#input\_checkout\_function\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_checkout_function_kind"></a> [checkout\_function\_kind](#input\_checkout\_function\_kind) | App service plan kind | `string` | `null` | no |
| <a name="input_checkout_function_sku_size"></a> [checkout\_function\_sku\_size](#input\_checkout\_function\_sku\_size) | App service plan sku size | `string` | `null` | no |
| <a name="input_checkout_function_sku_tier"></a> [checkout\_function\_sku\_tier](#input\_checkout\_function\_sku\_tier) | App service plan sku tier | `string` | `null` | no |
| <a name="input_checkout_function_worker_count"></a> [checkout\_function\_worker\_count](#input\_checkout\_function\_worker\_count) | (Optional) checkout function worker count number | `number` | `1` | no |
| <a name="input_checkout_function_zone_balancing_enabled"></a> [checkout\_function\_zone\_balancing\_enabled](#input\_checkout\_function\_zone\_balancing\_enabled) | (Optional) Enables zone balancing for checkout function | `bool` | `true` | no |
| <a name="input_checkout_pagopaproxy_host"></a> [checkout\_pagopaproxy\_host](#input\_checkout\_pagopaproxy\_host) | pagopaproxy host | `string` | `null` | no |
| <a name="input_cidr_subnet_checkout_be"></a> [cidr\_subnet\_checkout\_be](#input\_cidr\_subnet\_checkout\_be) | Address prefixes subnet checkout function | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_pagopa_proxy"></a> [cidr\_subnet\_pagopa\_proxy](#input\_cidr\_subnet\_pagopa\_proxy) | Address prefixes subnet proxy | `list(string)` | `null` | no |
| <a name="input_cidr_subnet_pagopa_proxy_ha"></a> [cidr\_subnet\_pagopa\_proxy\_ha](#input\_cidr\_subnet\_pagopa\_proxy\_ha) | Address prefixes subnet proxy ha | `list(string)` | `null` | no |
| <a name="input_dns_zone_checkout"></a> [dns\_zone\_checkout](#input\_dns\_zone\_checkout) | The checkout dns subdomain. | `string` | `null` | no |
| <a name="input_dns_zone_prefix"></a> [dns\_zone\_prefix](#input\_dns\_zone\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_ecommerce_ingress_hostname"></a> [ecommerce\_ingress\_hostname](#input\_ecommerce\_ingress\_hostname) | ecommerce ingress hostname | `string` | `null` | no |
| <a name="input_ecommerce_vpos_psps_list"></a> [ecommerce\_vpos\_psps\_list](#input\_ecommerce\_vpos\_psps\_list) | psps list using vpos as comma separated value | `string` | `""` | no |
| <a name="input_ecommerce_xpay_psps_list"></a> [ecommerce\_xpay\_psps\_list](#input\_ecommerce\_xpay\_psps\_list) | psps list using xpay as comma separated value | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_function_app_storage_account_info"></a> [function\_app\_storage\_account\_info](#input\_function\_app\_storage\_account\_info) | n/a | <pre>object({<br/>    account_kind                      = optional(string, "StorageV2")<br/>    account_tier                      = optional(string, "Standard")<br/>    account_replication_type          = optional(string, "LRS")<br/>    access_tier                       = optional(string, "Hot")<br/>    advanced_threat_protection_enable = optional(bool, true)<br/>    use_legacy_defender_version       = optional(bool, true)<br/>    public_network_access_enabled     = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "access_tier": "Hot",<br/>  "account_kind": "StorageV2",<br/>  "account_replication_type": "LRS",<br/>  "account_tier": "Standard",<br/>  "advanced_threat_protection_enable": true,<br/>  "public_network_access_enabled": false,<br/>  "use_legacy_defender_version": true<br/>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_pagopa_proxy_autoscale_default"></a> [pagopa\_proxy\_autoscale\_default](#input\_pagopa\_proxy\_autoscale\_default) | The number of instances that are available for scaling if metrics are not available for evaluation. | `number` | `5` | no |
| <a name="input_pagopa_proxy_autoscale_maximum"></a> [pagopa\_proxy\_autoscale\_maximum](#input\_pagopa\_proxy\_autoscale\_maximum) | The maximum number of instances for this resource. | `number` | `10` | no |
| <a name="input_pagopa_proxy_autoscale_minimum"></a> [pagopa\_proxy\_autoscale\_minimum](#input\_pagopa\_proxy\_autoscale\_minimum) | The minimum number of instances for this resource. | `number` | `1` | no |
| <a name="input_pagopa_proxy_ha_enabled"></a> [pagopa\_proxy\_ha\_enabled](#input\_pagopa\_proxy\_ha\_enabled) | (Required) enables the deployment of pagopa proxy in HA | `bool` | n/a | yes |
| <a name="input_pagopa_proxy_plan_sku"></a> [pagopa\_proxy\_plan\_sku](#input\_pagopa\_proxy\_plan\_sku) | (Required) pagopa proxy app service sku name | `string` | n/a | yes |
| <a name="input_pagopa_proxy_vnet_integration"></a> [pagopa\_proxy\_vnet\_integration](#input\_pagopa\_proxy\_vnet\_integration) | (Optional) enables vnet integration for pagopa proxy app service | `bool` | `true` | no |
| <a name="input_pagopa_proxy_zone_balance_enabled"></a> [pagopa\_proxy\_zone\_balance\_enabled](#input\_pagopa\_proxy\_zone\_balance\_enabled) | (Optional) enables zone balancing for pagopa proxy app service | `bool` | `true` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br/>  "CreatedBy": "Terraform"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
