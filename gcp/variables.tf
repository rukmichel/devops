variable "environment" {
  type=string
  default = "dev"
}
variable "storage_bucket_name" {
  type=string
}
variable "storage_bucket_location" {
  type=string
}

variable "alert_policy_config_file_path" {
  type = string
}