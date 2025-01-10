# data "ec_stack" "latest" {
#   version_regex = "latest"
#   region        = "azure-westeurope"
# }

data "azuread_application" "ec_application" {
  #display_name = "${local.prefix}-${var.env_short}-elasticcloud-app"
  display_name = "ElasticCloud"
}
