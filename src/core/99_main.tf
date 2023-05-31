terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.99.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.6.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.2.3"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "= 1.3.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

provider "azapi" {

}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

locals {
  project = format("%s-%s", var.prefix, var.env_short)
  project_pair = "${var.prefix}-${var.env_short}-${var.location_pair_short}"
}
