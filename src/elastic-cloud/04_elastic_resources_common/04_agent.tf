# resource "elasticstack_fleet_agent_policy" "kubernetes_policy" {
#   name            = "Elastic Agent on ECK policy ${var.env}"
#   namespace       = "default"
#   description     = "Test Agent Policy"
#   id = "eck-agent-${var.env}"
#   sys_monitoring  = false
#   monitor_logs    = true
#   monitor_metrics = true
# }


# todo move to deployment???
resource "elasticstack_fleet_integration" "kubernetes_package" {
  name    = "kubernetes"
  version = "1.70.1"
  force   = true
  skip_destroy = true
}

resource "elasticstack_fleet_integration" "system_package" {
  name    = "system"
  version = "1.64.0"
  force   = true
  skip_destroy = true
}

# apm creato tramite integration server nel deployment
# todo end move to deployment


locals {
   logs_general_to_exclude_paths_string = join(",", distinct(flatten([
    for instance_name in var.dedicated_log_instance_name : "'/var/log/containers/${instance_name}-*.log'"
  ])))
}

resource "elasticstack_fleet_integration_policy" "system_integration_policy" {
  name                = "system-1"
  namespace           = "default" # prefix-env
  description         = "A sample integration policy"
  agent_policy_id     = elasticstack_fleet_agent_policy.kubernetes_policy.policy_id
  integration_name    = elasticstack_fleet_integration.kubernetes_package.name
  integration_version = elasticstack_fleet_integration.kubernetes_package.version

  input {
    input_id = "tcp-tcp"
    streams_json = templatefile("kubernetes-integration-policy.json.tpl", {
      logs_general_to_exclude_paths = local.logs_general_to_exclude_paths_string
      dedicated_log_instance_name = var.dedicated_log_instance_name
      env = var.env
    })
  }
}


# todo
# il namespace dell'agent non deve essere "default" ma "prefix-env"
# cosi anche i nomi degli index e data stream nelle varia configurazioni delle app
