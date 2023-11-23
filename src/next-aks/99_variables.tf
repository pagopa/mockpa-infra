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

variable "enable_velero_backup" {
  type = bool
  description = "(Optional) If true, installs velero on the aks cluster and schedules the automatic backups"
  default = false
}


variable "velero_backup_ttl" {
  type = string
  default = "720h0m0s"
  description = "(Optional) TTL for velero backups. defaults to 30 days"
}

variable "velero_backup_schedule" {
  type = string
  default = "0 3 * * *"
  description = "(Optional) cron expression defining when to run the backups, expressed in UTC"
}

variable "velero_backup_sa_replication_type" {
  type = string
  default = "GZRS"
  description = "(Optional) backup storage account replication type"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace."
}


variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

variable "velero_sa_backup_retention_days" {
  type = number
  description = "(Optional) number of days for which the storage account is available for point in time recovery"
  default = 0
}

variable "velero_sa_backup_enabled" {
  type = bool
  description = "(Optional) enables storage account point in time recovery"
  default = false
}
