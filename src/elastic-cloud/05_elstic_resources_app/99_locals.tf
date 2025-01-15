locals {
  prefix             = "pagopa"
  config_folder_name = "config"
  config_files = fileset(path.module, "${local.config_folder_name}/*/*.json")
  configurations     = {
    for f in local.config_files : basename(f) => {
      conf = jsondecode(templatefile(f, {
            env               = var.env
            env_separator     = "${var.env}-"
            wait_for_snapshot = var.lifecycle_policy_wait_for_snapshot
          }))
      space_name = substr(dirname(f), length("${local.config_folder_name}/"), -1)
      dashboard_folder = "${dirname(f)}/dashboards"
    }
  }
  spaces = { for f in local.config_files : substr(dirname(f), length("${local.config_folder_name}/"), -1) => substr(dirname(f), length("${local.config_folder_name}/"), -1)}
}
