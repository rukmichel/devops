
variable "resource_group_name" {
  type=string
}
variable "resource_group_location" {
  type=string
}
variable "environment" {
  type=string
  default = "dev"
}
variable "subscription_id" {
  type=string
}
variable "alert_policy_lists" {
  description = "List of alert policies."
  type = list(object({
    alert_name           = string
    target_resource_name = string
    metric_namespace     = string
    metric_name          = string
    operator             = string
    threshold            = number
    aggregation          = string
    dimension = object({
      name     = string
      operator = string
      values   = list(string)
    })
  }))
}
