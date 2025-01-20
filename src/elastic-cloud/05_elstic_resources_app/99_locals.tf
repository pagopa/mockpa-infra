locals {
  prefix             = "pagopa"
  product = "${local.prefix}-${var.env}"
  config_folder_name = "config"
  config_files = fileset(path.module, "${local.config_folder_name}/*/*/appSettings.json")
  configurations     = {
    for f in local.config_files : jsondecode(file(f)).id => {
      conf = jsondecode(templatefile(f, {
            env               = var.env
            env_separator     = "${var.env}-"
            wait_for_snapshot = var.lifecycle_policy_wait_for_snapshot
            name = trimsuffix(basename(f), ".json")
          }))
      space_name = split("/", dirname(f))[1] #get space name from structure config/<space_name>/<application_name>
      dashboard_folder = "${dirname(f)}/dashboard"
      query_folder = "${dirname(f)}/query"
    }
  }
  spaces = toset([for f in local.config_files : split("/", dirname(f))[1]]) #get space name from structure config/<space_name>/<application_name>
}



