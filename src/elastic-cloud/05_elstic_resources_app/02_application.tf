resource "elasticstack_kibana_space" "kibana_space" {
  for_each = local.spaces
  space_id          = "${each.value}-${var.env}"
  name              = "${each.value}-${var.env}"
  description       = "Space for ${each.value}-${var.env}"
  disabled_features = []
}


module "app_resources" {
  source = "./tf_module"
  for_each = local.configurations

  configuration = each.value.conf
  default_snapshot_policy_name = var.default_snapshot_policy_name
  env = var.env
  space_id = elasticstack_kibana_space.kibana_space[each.value.space_name].id
  dashboard_folder = each.value.dashboard_folder
}



