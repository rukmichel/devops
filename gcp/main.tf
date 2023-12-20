# Configure the gcp provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.9.0"
    }
  }
  backend "gcs" {
    bucket = "tfstatestorage"
    prefix = "terraform/state"
    lock   = true
  }
}

provider "google" {
  # Configuration options
  credentials = file("/../credentials/future-badge-408115-581a9c564650.json")
  project     = "future-badge-408115"
  region      = "northamerica-northeast1"
}

resource "google_storage_bucket" "bucket" {
  name     = var.storage_bucket_name
  location = var.storage_bucket_location
  labels = {
    environment = var.environment
  }
}

module "gcp_vm" {
  source = "./vm"
}

module "gcp_monitoring" {
  source                        = "./gcpmonitoring"
  alert_policy_config_file_path = var.alert_policy_config_file_path
}
