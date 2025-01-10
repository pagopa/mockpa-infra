# resource "azuread_application_identifier_uri" "az_application_identifier_uri" {
#   application_id = data.azuread_application.ec_application.id
#   identifier_uri = local.kibana_url
# }
#
#
# resource "azuread_application_redirect_uris" "az_application_redirect_uri" {
#   application_id = data.azuread_application.ec_application.id
#   type           = "PublicClient"
#
#   redirect_uris = [
#     "${local.kibana_url}/api/security/saml/callback",
#   ]
#
#   # fixme manca la logout url
# }
