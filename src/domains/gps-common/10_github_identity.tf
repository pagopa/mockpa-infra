data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

# repos must be lower than 20 items
locals {
  repos_01 = [
    "pagopa-gpd-upload",
    "pagopa-gpd-upload-function"
  ]

  federations_01 = [
    for repo in local.repos_01 : {
      repository = repo
      subject    = var.env
    }
  ]

  environment_cd_roles = {
    subscription = [
      "Reader"
    ]
    resource_groups = {
      "${local.product}-${var.domain}-sec-rg" = [
        "Key Vault Reader"
      ],
      "${local.product}-${var.location_short}-${var.env}-aks-rg" = [
        "Contributor"
      ]
    }
  }
}

# create a module for each 20 repos
module "identity_cd_01" {
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.45.0"
  # pagopa-<ENV><DOMAIN>-<COUNTER>-github-<PERMS>-identity
  prefix    = var.prefix
  env_short = var.env_short
  domain    = "${var.domain}-01"

  identity_role = "cd"

  github_federations = local.federations_01

  cd_rbac_roles = {
    subscription_roles = local.environment_cd_roles.subscription
    resource_groups    = local.environment_cd_roles.resource_groups
  }

  tags = var.tags

  depends_on = [
    data.azurerm_resource_group.identity_rg
  ]
}
