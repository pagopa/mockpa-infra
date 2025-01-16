locals {
  dashboards = { for df in fileset("${var.dashboard_folder}", "/*.ndjson") : trimsuffix(basename(df), ".ndjson") => "${var.dashboard_folder}/${df}" }
  queries = { for df in fileset("${var.query_folder}", "/*.ndjson") : trimsuffix(basename(df), ".ndjson") => "${var.query_folder}/${df}" }
}


resource "elasticstack_kibana_space" "kibana_space" {
  space_id          = "${var.space_name}-${var.env}"
  name              = "${var.space_name}-${var.env}"
  description       = "Space for ${var.space_name}-${var.env}"
  disabled_features = []
}

resource "elasticstack_kibana_import_saved_objects" "dashboard" {
  for_each = local.dashboards

  overwrite     = true

  file_contents = file(each.value)

}

resource "elasticstack_kibana_import_saved_objects" "query" {
  for_each = local.queries

  overwrite     = true

  file_contents = file(each.value)
}


