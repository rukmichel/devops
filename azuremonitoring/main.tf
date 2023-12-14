resource "azurerm_resource_group" "monitorRg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

data "azurerm_client_config" "current" {
}

resource "azurerm_monitor_action_group" "monitor_action_group" {
  name                = "CriticalAlertsAction"
  resource_group_name = azurerm_resource_group.monitorRg.name
  short_name          = "critical-ag"

  email_receiver {
    name          = "michel"
    email_address = "michel.mutabesha@cgi.com"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_monitor_metric_alert" "alert_policy" {
  for_each = { for policy in var.alert_policy_lists : policy.alert_name => policy }

  name                = each.value.alert_name
  resource_group_name = azurerm_resource_group.monitorRg.name
  scopes              = ["/subscriptions/${var.subscription_id}/resourceGroups/${azurerm_resource_group.monitorRg.name}/providers/${each.value.metric_namespace}/${each.value.target_resource_name}"]
  description         = "Alert policy for ${each.value.target_resource_name}"
  enabled             = true

  criteria {
    metric_namespace = each.value.metric_namespace
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold

    # Add dimensions conditionally based on metric_namespace containing "StorageAccount"
    dynamic "dimension" {
      for_each = each.value.dimension != null ? [each.value.dimension] : []
      content {
        name     = each.value.dimension.name
        operator = each.value.dimension.operator
        values   = each.value.dimension.values
      }
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.monitor_action_group.id
  }
}
