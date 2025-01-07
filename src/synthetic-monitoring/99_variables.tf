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


variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
  }
}

variable "env" {
  type = string
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



variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
#
# Feature flags
#
variable "enabled_resource" {
  type = object({
    container_app_tools_cae = optional(bool, false),
  })
}

variable "storage_account_replication_type" {
  type        = string
  description = "(Required) table storage replication type"
}

variable "use_private_endpoint" {
  type        = bool
  description = "(Required) if true enables the usage of private endpoint"
}


## Monitor
variable "law_sku" {
  type        = string
  description = "Sku of the Log Analytics Workspace"
  default     = "PerGB2018"
}

variable "law_retention_in_days" {
  type        = number
  description = "The workspace data retention in days"
  default     = 30
}

variable "law_daily_quota_gb" {
  type        = number
  description = "The workspace daily quota for ingestion in GB."
  default     = -1
}

variable "self_alert_enabled" {
  type        = bool
  description = "(Optional) enables the alert on the function itself"
  default     = true
}


variable "check_position_body" {
  type = object({
    fiscal_code   = string
    notice_number = string
  })
  description = "(Required) fiscal code and notice number to be used in synthetic checkposition request body"
}

variable "synthetic_alerts_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enables alerts generated by the synthetic monitoring probe"
}

variable "verify_payment_internal_expected_outcome" {
  type        = string
  description = "(Required) Expected outcome for verify payment notice internal"
}

variable "nexi_node_ip" {
  type        = string
  description = "Nodo Pagamenti Nexi ip"
}
variable "nexi_ndp_host" {
  type        = string
  description = "Nodo Pagamenti Nexi ip"
}
