# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "eatus-storage-rg"
    storage_account_name = "tfstate53yvh"
    container_name       = "tfstate"
    key                  = "tfstate"
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

module "example_module" {
  source                 = "./azurestorage"
  storage_account_name   = "tfstate53yvh"
  storage_container_name = "tfstate"
}

data "local_file" "alert_policy_config" {
  filename = "./alertpolicyconfigs/alert_policy_config.yaml"
}

locals {
  alert_policy_config = yamldecode(data.local_file.alert_policy_config.content)
}

module "azuremonitoring" {
  source             = "./azuremonitoring"
  alert_policy_lists = local.alert_policy_config["alert_policy_lists"]
  subscription_id = var.subscription_id
  resource_group_name = var.resource_group_name
  resource_group_location= var.resource_group_location
}
