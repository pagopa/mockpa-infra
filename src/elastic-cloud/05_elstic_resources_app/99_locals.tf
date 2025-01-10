locals {
  prefix = "pagopa"
  config_files = fileset(path.module, "config/*.json" )
  configurations ={ for f in local.config_files : basename(f) =>  jsondecode(templatefile(f, {
    env = var.env
    env_separator = "${var.env}-"
    wait_for_snapshot = var.lifecycle_policy_wait_for_snapshot
  }))}
}
