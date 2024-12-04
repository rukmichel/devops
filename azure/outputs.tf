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

output "monitor_action_group_id" {
  value       = module.azuremonitoring.monitor_action_group_id
  description = "The id of the azure monitor action group created"
}
output "alert_policy_ids" {
  value       = module.azuremonitoring.alert_policy_ids
  description = "The id of the alert policy created"
}
