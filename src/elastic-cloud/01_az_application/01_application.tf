resource "azuread_application" "ec_application" {
  display_name     = "${local.project}-app"
  identifier_uris  = ["api://${local.project}-app"]
  owners           = [data.azuread_client_config.current.object_id]
}
