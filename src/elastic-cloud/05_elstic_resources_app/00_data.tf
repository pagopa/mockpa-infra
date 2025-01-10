data "ec_deployment" "ec_deployment" {
  id = var.ec_deployment_id
}

data "azuread_application" "ec_application" {
  #display_name = "${local.prefix}-${var.env_short}-elasticcloud-app"
  display_name = "ElasticCloud"
}

