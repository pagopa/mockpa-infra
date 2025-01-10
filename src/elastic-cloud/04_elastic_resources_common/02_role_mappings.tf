# all users in realm as kibana admin
resource "elasticstack_elasticsearch_security_role_mapping" "application_users_as_kibana_admin" {
  name    = "${data.azuread_application.ec_application.display_name}-kibana-admin"
  enabled = true
  roles = [
    "kibana_admin"
  ]
  rules = jsonencode({
    all = [
      { field = { "realm.name" = local.realm_name } },
    ]
  })
}

# admin users in realm as kibana superusers
resource "elasticstack_elasticsearch_security_role_mapping" "admins_as_superuser" {
  name    = "${data.azuread_application.ec_application.display_name}-admins-as-superusers"
  enabled = true
  roles = [
    "superuser"
  ]
  rules = jsonencode({
    all = [
      { field = { "realm.name" = local.realm_name } },
      { field = { username = local.admins_email }}
    ]
  })
}
