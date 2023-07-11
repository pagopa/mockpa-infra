# general

variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env" {
  type = string
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
  }
}

variable "github" {
  type = object({
    org = string
  })
  default = { org = "pagopa" }
}

variable "domain" {
  type = string
  validation {
    condition = (
      length(var.domain) <= 12
    )
    error_message = "Max length is 12 chars."
  }
}

variable "location" {
  type        = string
  description = "One of westeurope, northeurope"
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of wue, neu"
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

### External resources

variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace."
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace is located in."
}

variable "ingress_load_balancer_ip" {
  type = string
}

### Aks

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}
variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "apim_dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain for apim."
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}



variable "cidr_subnet_flex_dbms" {
  type        = list(string)
  description = "Postgresql network address space."
}

# Postgres Flexible
variable "pgres_flex_params" {
  type = object({
    enabled                                = bool
    sku_name                               = string
    db_version                             = string
    storage_mb                             = string
    zone                                   = number
    backup_retention_days                  = number
    geo_redundant_backup_enabled           = bool
    create_mode                            = string
    pgres_flex_private_endpoint_enabled    = bool
    pgres_flex_ha_enabled                  = bool
    pgres_flex_pgbouncer_enabled           = bool
    pgres_flex_diagnostic_settings_enabled = bool
    max_connections                        = number
  })

}

variable "pgres_flex_fdr_db_name" {
  type        = string
  description = "FdR DB name"
  default     = "fdr"
}

variable "custom_metric_alerts" {

  description = <<EOD
  Map of name = criteria objects
  EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    metric_name = string
    # "Insights.Container/pods" "Insights.Container/nodes"
    metric_namespace = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
    frequency = string
    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
    window_size = string
    # severity: The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3.
    severity = number
  }))

  default = {
    cpu_percent = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Average"
      metric_name      = "cpu_percent"
      operator         = "GreaterThan"
      threshold        = 4500
      severity         = 2
    },
    memory_percent = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Average"
      metric_name      = "memory_percent"
      operator         = "GreaterThan"
      threshold        = 80
      severity         = 2
    },
    storage_percent = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Average"
      metric_name      = "storage_percent"
      operator         = "GreaterThan"
      threshold        = 80
      severity         = 2
    },
    active_connections = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Average"
      metric_name      = "active_connections"
      operator         = "GreaterThan"
      threshold        = 80
      severity         = 2
    },
    connections_failed = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Total"
      metric_name      = "connections_failed"
      operator         = "GreaterThan"
      threshold        = 80
      severity         = 2
    }
  }
}

# CosmosDb
variable "cidr_subnet_cosmosdb_fdr" {
  type        = list(string)
  description = "Cosmos DB address space for fdr."
}

variable "cosmos_mongo_db_fdr_params" {
  type = object({
    enabled        = bool
    capabilities   = list(string)
    offer_type     = string
    server_version = string
    kind           = string
    consistency_policy = object({
      consistency_level       = string
      max_interval_in_seconds = number
      max_staleness_prefix    = number
    })
    main_geo_location_zone_redundant = bool
    enable_free_tier                 = bool
    main_geo_location_zone_redundant = bool
    additional_geo_locations = list(object({
      location          = string
      failover_priority = number
      zone_redundant    = bool
    }))
    private_endpoint_enabled          = bool
    public_network_access_enabled     = bool
    is_virtual_network_filter_enabled = bool
    backup_continuous_enabled         = bool
    enable_serverless  = bool
    enable_autoscaling = bool
    throughput         = number
    max_throughput     = number
  })
}

#variable "cosmos_mongo_db_fdr_params" {
#  type = object({
# enable_serverless  = bool
#enable_autoscaling = bool
#throughput         = number
#max_throughput     = number
#  })
#}

variable "fdr_convertion_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
}

# Storage account
variable "cidr_subnet_storage_account" {
  type        = list(string)
  description = "Storage account network address space."
}

#variable "fdr_advanced_threat_protection" {
#  type        = bool
#  description = "Enable contract threat advanced protection"
#  default     = false
#}

#variable "fdr_enable_versioning" {
#  type        = bool
#  description = "Enable sa versioning"
#  default     = false
#}

#variable "fdr_delete_retention_days" {
#  type        = number
#  description = "Number of days to retain deleted."
#  default     = 30
#}

variable "reporting_fdr_blobs_retention_days" {
  type        = number
  description = "The number of day for storage_management_policy"
  default     = 30
}

variable "fdr_re_versioning" {
  type        = bool
  description = "Enable sa versioning"
  default     = false
}
variable "fdr_re_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}
variable "fdr_re_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
}

variable "fdr_storage_account" {
  type = object({
    account_kind                  = string
    account_tier                  = string
    account_replication_type      = string
    advanced_threat_protection    = bool
    blob_versioning_enabled       = bool
    public_network_access_enabled = bool
    blob_delete_retention_days    = number
    enable_low_availability_alert = bool
  })

  default = {
    account_kind                  = "StorageV2"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    blob_versioning_enabled       = false
    advanced_threat_protection    = true
    public_network_access_enabled = false
    blob_delete_retention_days    = 30
    enable_low_availability_alert = false
  }
}

variable "fdr_re_storage_account" {
  type = object({
    account_kind                  = string
    account_tier                  = string
    account_replication_type      = string
    advanced_threat_protection    = bool
    blob_versioning_enabled       = bool
    public_network_access_enabled = bool
    blob_delete_retention_days    = number
    enable_low_availability_alert = bool
  })

  default = {
    account_kind                  = "StorageV2"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    blob_versioning_enabled       = false
    advanced_threat_protection    = true
    public_network_access_enabled = false
    blob_delete_retention_days    = 30
    enable_low_availability_alert = false
  }
}

variable "reporting_fdr_storage_account" {
  type = object({
    advanced_threat_protection    = bool
    blob_versioning_enabled       = bool
    blob_delete_retention_days    = number
  })

  default = {
    advanced_threat_protection    = false
    blob_versioning_enabled       = false
    blob_delete_retention_days    = 30
  }
}
