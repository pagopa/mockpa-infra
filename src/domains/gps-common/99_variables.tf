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

variable "gpd_payments_versioning" {
  type        = bool
  description = "Enable sa versioning"
  default     = false
}

variable "gpd_payments_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "gpd_payments_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
}

variable "gpd_enable_versioning" {
  type        = bool
  description = "Enable sa versioning"
  default     = false
}

variable "gpd_reporting_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "gpd_reporting_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
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

variable "application_insights_name" {
  type        = string
  description = "Specifies the name of the Application Insights."
}

variable "ingress_load_balancer_ip" {
  type = string
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

variable "cidr_subnet_pg_flex_dbms" {
  type        = list(string)
  description = "Postgres Flexible Server network address space."
}

# Postgres Flexible
variable "pgres_flex_params" {
  type = object({
    private_endpoint_enabled     = bool
    sku_name                     = string
    db_version                   = string
    storage_mb                   = string
    zone                         = number
    backup_retention_days        = number
    geo_redundant_backup_enabled = bool
    high_availability_enabled    = bool
    standby_availability_zone    = number
    pgbouncer_enabled            = bool
  })

  default = null
}

// gpd Database
variable "gpd_db_name" {
  type        = string
  description = "Name of the DB to connect to"
  default     = "apd"
}

variable "cosmos_gps_db_params" {
  type = object({
    kind           = string
    capabilities   = list(string)
    offer_type     = string
    server_version = string
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
  })
}

variable "cidr_subnet_gps_cosmosdb" {
  type        = list(string)
  description = "Cosmos DB address space"
  default     = null
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}
