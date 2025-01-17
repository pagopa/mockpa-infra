variable "configuration" {
  type = any
}

variable "default_snapshot_policy_name" {
  type = string
}

variable "space_id" {
  type = string
}

variable "env" {
  type = string
}



variable "default_ingest_pipeline_conf" {
  type = any
}

variable "default_ilm_conf" {
  type = any
}

variable "default_component_package" {
  type = any
}

variable "query_folder" {
  type = string
}

variable "dashboard_folder" {
  type = string
}
