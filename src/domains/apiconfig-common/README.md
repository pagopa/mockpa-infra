# apiconfig-common

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.38.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_github_runner"></a> [github\_runner](#module\_github\_runner) | git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment | v4.1.17 |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault | v4.1.17 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.afm_cosmos_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.afm_marketplace_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.afm_utils_subscription_key](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.ai_connection_string](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.oracle_db_cfg_password](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.postgresql_db_cfg_password](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/key_vault_secret) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_resource_group.github_runner_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.github_runner_snet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/resources/subnet) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/service_principal) | data source |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.cosmos](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.storage](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/subnet) | data source |
| [azurerm_subnet.apiconfig_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.38.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_dns_zone_prefix"></a> [apim\_dns\_zone\_prefix](#input\_apim\_dns\_zone\_prefix) | The dns subdomain for apim. | `string` | `null` | no |
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Specifies the name of the Application Insights. | `string` | n/a | yes |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_github"></a> [github](#input\_github) | n/a | <pre>object({<br>    org = string<br>  })</pre> | <pre>{<br>  "org": "pagopa"<br>}</pre> | no |
| <a name="input_github_runner"></a> [github\_runner](#input\_github\_runner) | GitHub runner variables | <pre>object({<br>    subnet_address_prefixes = list(string)<br>  })</pre> | <pre>{<br>  "subnet_address_prefixes": [<br>    "10.1.164.0/23"<br>  ]<br>}</pre> | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
