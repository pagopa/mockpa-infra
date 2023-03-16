<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 2.21.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.99.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postgres_flexible_server"></a> [postgres\_flexible\_server](#module\_postgres\_flexible\_server) | git::https://github.com/pagopa/azurerm.git//postgres_flexible_server | v2.12.3 |
| <a name="module_postgres_flexible_snet"></a> [postgres\_flexible\_snet](#module\_postgres\_flexible\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v2.1.13 |
| <a name="module_sftp"></a> [sftp](#module\_sftp) | git::https://github.com/pagopa/azurerm.git//storage_account | v4.3.0 |
| <a name="module_storage_account_snet"></a> [storage\_account\_snet](#module\_storage\_account\_snet) | git::https://github.com/pagopa/azurerm.git//subnet | v4.3.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_data_factory.data_factory](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/data_factory) | resource |
| [azurerm_data_factory_integration_runtime_azure.autoresolve](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/data_factory_integration_runtime_azure) | resource |
| [azurerm_monitor_action_group.slack](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/monitor_action_group) | resource |
| [azurerm_postgresql_flexible_server_configuration.nodo_db_flex_default_pool_size](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.nodo_db_flex_ignore_startup_parameters](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.nodo_db_flex_max_connection](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_configuration.nodo_db_flex_min_pool_size](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.nodo_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_flexible_server_database.nodo_replica_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_private_dns_a_record.data_factory_a_record](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_a_record.ingress](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_zone.adf](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.adf_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.data_factory_pe](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint.sftp_blob](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.data_factory_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.db_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sftp](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/resource_group) | resource |
| [azurerm_storage_blob.sogei_dirs](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.sogei](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/storage_container) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.21.0/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_login](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.pgres_flex_admin_pwd](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.slackemail](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/key_vault_secret) | data source |
| [azurerm_log_analytics_workspace.log_analytics](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_monitor_action_group.email](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/monitor_action_group) | data source |
| [azurerm_private_dns_zone.internal](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.privatelink_redis_azure_com](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_private_dns_zone.storage](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.monitor_rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subnet) | data source |
| [azurerm_subnet.private_endpoint_snet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_subnet_flex_dbms"></a> [cidr\_subnet\_flex\_dbms](#input\_cidr\_subnet\_flex\_dbms) | Postgresql network address space. | `list(string)` | n/a | yes |
| <a name="input_cidr_subnet_ndp_redis"></a> [cidr\_subnet\_ndp\_redis](#input\_cidr\_subnet\_ndp\_redis) | Redis DB address space for NDP. | `list(string)` | <pre>[<br>  "10.1.162.0/24"<br>]</pre> | no |
| <a name="input_cidr_subnet_storage_account"></a> [cidr\_subnet\_storage\_account](#input\_cidr\_subnet\_storage\_account) | Storage account network address space. | `list(string)` | n/a | yes |
| <a name="input_custom_metric_alerts"></a> [custom\_metric\_alerts](#input\_custom\_metric\_alerts) | Map of name = criteria objects | <pre>map(object({<br>    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]<br>    aggregation = string<br>    metric_name = string<br>    # "Insights.Container/pods" "Insights.Container/nodes"<br>    metric_namespace = string<br>    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]<br>    operator  = string<br>    threshold = number<br>    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H<br>    frequency = string<br>    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.<br>    window_size = string<br>    # severity: The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3.<br>    severity = number<br>  }))</pre> | <pre>{<br>  "active_connections": {<br>    "aggregation": "Average",<br>    "frequency": "PT5M",<br>    "metric_name": "active_connections",<br>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 80,<br>    "window_size": "PT30M"<br>  },<br>  "connections_failed": {<br>    "aggregation": "Total",<br>    "frequency": "PT5M",<br>    "metric_name": "connections_failed",<br>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 80,<br>    "window_size": "PT30M"<br>  },<br>  "cpu_percent": {<br>    "aggregation": "Average",<br>    "frequency": "PT5M",<br>    "metric_name": "cpu_percent",<br>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 4500,<br>    "window_size": "PT30M"<br>  },<br>  "memory_percent": {<br>    "aggregation": "Average",<br>    "frequency": "PT5M",<br>    "metric_name": "memory_percent",<br>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 80,<br>    "window_size": "PT30M"<br>  },<br>  "storage_percent": {<br>    "aggregation": "Average",<br>    "frequency": "PT5M",<br>    "metric_name": "storage_percent",<br>    "metric_namespace": "Microsoft.DBforPostgreSQL/flexibleServers",<br>    "operator": "GreaterThan",<br>    "severity": 2,<br>    "threshold": 80,<br>    "window_size": "PT30M"<br>  }<br>}</pre> | no |
| <a name="input_dns_zone_internal_prefix"></a> [dns\_zone\_internal\_prefix](#input\_dns\_zone\_internal\_prefix) | The dns subdomain. | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_external_domain"></a> [external\_domain](#input\_external\_domain) | Domain for delegation | `string` | `null` | no |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_ndp_redis_params"></a> [ndp\_redis\_params](#input\_ndp\_redis\_params) | n/a | <pre>object({<br>    capacity = number<br>    sku_name = string<br>    family   = string<br>  })</pre> | <pre>{<br>  "capacity": 0,<br>  "family": "C",<br>  "sku_name": "Basic"<br>}</pre> | no |
| <a name="input_pgres_flex_nodo_db_name"></a> [pgres\_flex\_nodo\_db\_name](#input\_pgres\_flex\_nodo\_db\_name) | Nodo DB name | `string` | `"nodo"` | no |
| <a name="input_pgres_flex_params"></a> [pgres\_flex\_params](#input\_pgres\_flex\_params) | Postgres Flexible | <pre>object({<br>    enabled                                = bool<br>    sku_name                               = string<br>    db_version                             = string<br>    storage_mb                             = string<br>    zone                                   = number<br>    backup_retention_days                  = number<br>    geo_redundant_backup_enabled           = bool<br>    create_mode                            = string<br>    pgres_flex_private_endpoint_enabled    = bool<br>    pgres_flex_ha_enabled                  = bool<br>    pgres_flex_pgbouncer_enabled           = bool<br>    pgres_flex_diagnostic_settings_enabled = bool<br>    max_connections                        = number<br>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_sftp_account_replication_type"></a> [sftp\_account\_replication\_type](#input\_sftp\_account\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa | `string` | n/a | yes |
| <a name="input_sftp_disable_network_rules"></a> [sftp\_disable\_network\_rules](#input\_sftp\_disable\_network\_rules) | If false, allow any connection from outside the vnet | `bool` | `false` | no |
| <a name="input_sftp_enable_private_endpoint"></a> [sftp\_enable\_private\_endpoint](#input\_sftp\_enable\_private\_endpoint) | If true, create a private endpoint for the SFTP storage account | `bool` | n/a | yes |
| <a name="input_sftp_ip_rules"></a> [sftp\_ip\_rules](#input\_sftp\_ip\_rules) | List of public IP or IP ranges in CIDR Format allowed to access the storage account. Only IPV4 addresses are allowed | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "CreatedBy": "Terraform"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
