output "monitor_action_group_id" {
  value = azurerm_monitor_action_group.monitor_action_group.id
  description = "The id of the azure monitor action group created"
}

output "alert_policy_ids" {
  value = { 
    for key, alert_policy in azurerm_monitor_metric_alert.alert_policy : 
    key => alert_policy.id
  }
  description = "The id of the alert policy created"
}
