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
output "azurerm_storage_container" {
  value = module.example_module.storage_account_name
}
output "container_name" {
  value = module.example_module.container_name
}
output "access_key" {
  value     = module.example_module.access_key
  sensitive = true
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
}

output "monitor_action_group_id" {
  value       = module.azuremonitoring.monitor_action_group_id
  description = "The id of the azure monitor action group created"
}

output "alert_policy_ids" {
  value       = module.azuremonitoring.alert_policy_ids
  description = "The id of the alert policy created"
}
