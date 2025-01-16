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

variable "ec_deployment_id" {
  type = string
  description = "(Required) identifier of EC deployment"
}


variable "lifecycle_policy_wait_for_snapshot" {
  type = bool
  description = "(Optional) True if the index lifecycle policy has to wait for snapshots before deletion"
  default = true
}
