# checkout-common

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | = 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.99.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.2.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_pagopa_proxy_redis"></a> [pagopa\_proxy\_redis](#module\_pagopa\_proxy\_redis) | git::https://github.com/pagopa/azurerm.git//redis_cache | v2.0.28 |
| <a name="module_pagopa_proxy_redis_snet"></a> [pagopa\_proxy\_redis\_snet](#module\_pagopa\_proxy\_redis\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.0.28 |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.pagopa_proxy_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/api_management) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/client_config) | data source |
| [azurerm_private_dns_zone.privatelink_redis_cache_windows_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.rg_api](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.apim_snet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subnet) | data source |
| [azurerm_subnet.azdoa_snet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_checkout_enabled"></a> [checkout\_enabled](#input\_checkout\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_cidr_subnet_pagopa_proxy_redis"></a> [cidr\_subnet\_pagopa\_proxy\_redis](#input\_cidr\_subnet\_pagopa\_proxy\_redis) | Address prefixes subnet redis for pagopa proxy | `list(string)` | `null` | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_pagopa_proxy_redis_capacity"></a> [pagopa\_proxy\_redis\_capacity](#input\_pagopa\_proxy\_redis\_capacity) | n/a | `number` | `1` | no |
| <a name="input_pagopa_proxy_redis_family"></a> [pagopa\_proxy\_redis\_family](#input\_pagopa\_proxy\_redis\_family) | n/a | `string` | `"C"` | no |
| <a name="input_pagopa_proxy_redis_sku_name"></a> [pagopa\_proxy\_redis\_sku\_name](#input\_pagopa\_proxy\_redis\_sku\_name) | n/a | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_redis_private_endpoint_enabled"></a> [redis\_private\_endpoint\_enabled](#input\_redis\_private\_endpoint\_enabled) | Enable private endpoints for redis instances? | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
