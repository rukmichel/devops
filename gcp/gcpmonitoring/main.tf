data "local_file" "alert_policy_config" {
  filename = var.alert_policy_config_file_path
}

locals {
  alert_policy_config = yamldecode(data.local_file.alert_policy_config.content)
  alert_policy_lists  = local.alert_policy_config["alert_policy_lists"]
}

resource "google_monitoring_notification_channel" "yamlsettings" {
  display_name = "Notification Channel by yamlsettings"
  type         = "email"
  labels = {
    email_address = ""
  }
}

resource "google_monitoring_alert_policy" "yamlsettings" {
  for_each = { for policy in local.alert_policy_lists : policy.display_name => policy }

  display_name = each.value.display_name
  combiner     = each.value.combiner
  dynamic "conditions" {
    for_each = {for index,condition in each.value.conditions: index => condition}
    content {
      display_name = conditions.value.display_name
      condition_threshold {
        filter     = conditions.value.condition_threshold.filter
        duration   = conditions.value.condition_threshold.duration
        comparison = conditions.value.condition_threshold.comparison
        aggregations {
          alignment_period   = conditions.value.condition_threshold.aggregations.alignment_period
          per_series_aligner = conditions.value.condition_threshold.aggregations.per_series_aligner
        }
        threshold_value = conditions.value.condition_threshold.threshold_value
      }
    }
  }
  notification_channels = [google_monitoring_notification_channel.yamlsettings.id]
  user_labels = {
    environment = var.environment
  }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy
