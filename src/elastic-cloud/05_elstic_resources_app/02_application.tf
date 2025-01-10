module "app_resources" {
  source = "./tf_module"
  for_each = local.configurations

  configuration = each.value
  default_snapshot_policy_name = var.default_snapshot_policy_name
}
