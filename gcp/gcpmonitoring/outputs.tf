output "google_monitoring_notification_channel_id" {
  value = google_monitoring_notification_channel.yamlsettings.id
  description = "The id of the GCP monitoring notification channel created"
}

output "alert_policy_ids" {
  value = { 
    for key, alert_policy in google_monitoring_alert_policy.yamlsettings : 
    key => alert_policy.id
  }
  description = "The id of the alert policy created"
}

