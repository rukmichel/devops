output "google_monitoring_notification_channel_id" {
  value = module.gcp_monitoring.google_monitoring_notification_channel_id
  description = "The id of the GCP monitoring notification channel created"
}

output "alert_policy_ids" {
  value = module.gcp_monitoring.alert_policy_ids
  description = "The id of the alert policy created"
}