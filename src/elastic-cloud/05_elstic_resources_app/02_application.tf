

# resource "elasticstack_kibana_space" "kibana_space" {
#   for_each = local.spaces
#   space_id          = "${each.value}-${var.env}"
#   name              = "${each.value}-${var.env}"
#   description       = "Space for ${each.value}-${var.env}"
#   disabled_features = []
# }


# fixme - crea le dashboard che fanno riferimento alle data view, e va in errore se non esistono
# fixme - le data view hanno nome diverso (e non contengono l'ambiente)
# fixme - soluzione più comoda? avere gli ambienti separati dev e uat, cosi non c'è ambiente nellla data view
module "space_resources" {
  source = "./tf_module/space_resources"
  for_each = local.spaces

  space_name = each.key
  query_folder = "${path.module}/${local.config_folder_name}/${each.key}/query"
  dashboard_folder = "${path.module}/${local.config_folder_name}/${each.key}/dashboard"
  env = var.env
}


module "app_resources" {
  source = "./tf_module/app_resources"
  for_each = local.configurations

  configuration = each.value.conf
  default_snapshot_policy_name = var.default_snapshot_policy_name
  env = var.env
  space_id = module.space_resources[each.value.space_name].space_id

  default_ilm_conf = local.default_ilm
  default_ingest_pipeline_conf = local.default_ingest_pipeline
  default_component_package = jsondecode(templatefile("./defaults/component@package.json", {
    name =  each.key
  }))

  elasticsearch_api_key = var.elasticsearch_api_key
  kibana_endpoint = data.ec_deployment.ec_deployment.kibana[0].https_endpoint
}





