variable "subscription_id"{
  type=string
}
variable "client_id"{
  type=string
}
variable "client_secret"{
  type=string
}
variable "tenant_id"{
  type=string
}

variable "resource_group_name" {
  default = "eatus-storage-rg"
}
variable "resource_group_location" {
  default = "East US"
}