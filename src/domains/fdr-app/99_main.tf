terraform {
  required_version = ">=1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.30.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.12.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.11.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.12.1"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "github" {
  owner = var.github.org
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
  }
}

module "__v3__" {
  # v8.60.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=551a56a4bf841cd431b51ec951639e74260daf6a"
}

