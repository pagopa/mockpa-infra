resource "elasticstack_kibana_space" "kibana_space" {
  for_each = local.spaces
  space_id          = "${each.value}-${var.env}"
  name              = "${each.value}-${var.env}"
  description       = "Space for ${each.value}-${var.env}"
  disabled_features = []
}


module "app_resources" {
  source = "./tf_module/app_resources"
  for_each = local.configurations

  configuration = each.value.conf
  default_snapshot_policy_name = var.default_snapshot_policy_name
  env = var.env
  space_id = elasticstack_kibana_space.kibana_space[each.value.space_name].space_id

  default_ilm_conf = local.default_ilm
  default_ingest_pipeline_conf = local.default_ingest_pipeline

  default_component_custom_template = "./defaults/component@custom.json"
  default_component_package_template = "./defaults/component@package.json"

  query_folder = each.value.query_folder
  dashboard_folder = each.value.dashboard_folder
}




