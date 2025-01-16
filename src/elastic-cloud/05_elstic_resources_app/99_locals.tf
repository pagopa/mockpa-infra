locals {
  prefix             = "pagopa"
  product = "${local.prefix}-${var.env}"
  config_folder_name = "config"
  config_files = fileset(path.module, "${local.config_folder_name}/*/*.json")
  configurations     = {
    for f in local.config_files : trimsuffix(basename(f), ".json") => {
      conf = jsondecode(templatefile(f, {
            env               = var.env
            env_separator     = "${var.env}-"
            wait_for_snapshot = var.lifecycle_policy_wait_for_snapshot
            name = trimsuffix(basename(f), ".json")
          }))
      space_name = substr(dirname(f), length("${local.config_folder_name}/"), -1)
      dashboard_folder = "${dirname(f)}/dashboards"
    }
  }
  unique_space_folders = toset([for f in local.config_files : dirname(f)])
  spaces = { for f in local.unique_space_folders : substr(f, length("${local.config_folder_name}/"), -1) => substr(f, length("${local.config_folder_name}/"), -1)}
}
