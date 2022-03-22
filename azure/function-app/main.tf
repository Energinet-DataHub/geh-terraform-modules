# Copyright 2020 Energinet DataHub A/S
#
# Licensed under the Apache License, Version 2.0 (the "License2");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
locals {
  module_tags = {
    "ModuleVersion" = "5.9.0",
    "ModuleId"      = "azure-function-app"
  }
}

resource "azurerm_storage_account" "this" {
  name                      = "st${random_string.this.result}"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  min_tls_version           = "TLS1_2"

  tags                      = merge(var.tags,local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "random_string" "this" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_function_app" "this" {
  name                        = "func-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  app_service_plan_id         = var.app_service_plan_id
  storage_account_name        = azurerm_storage_account.this.name
  storage_account_access_key  = azurerm_storage_account.this.primary_access_key
  version                     = "~3"
  https_only                  = true
  app_settings                = merge({
    APPINSIGHTS_INSTRUMENTATIONKEY = var.application_insights_instrumentation_key
  },var.app_settings)
  identity {
    type = "SystemAssigned"
  }
  site_config {
    always_on = var.always_on
    health_check_path = var.health_check_path
    cors {
      allowed_origins = ["*"]
    }
  }
  dynamic "connection_string" {
    for_each  = var.connection_strings
    content {
      name  = connection_strings.key
      value = connection_strings.value
      type  = "Custom"
    }
  }

  tags                        = merge(var.tags, local.module_tags)

  depends_on                  = [
    azurerm_storage_account.this,
  ]

  lifecycle {
    ignore_changes = [
      source_control,
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_monitor_metric_alert" "health_check_alert" {
  count               = var.health_check_alert_action_group_id == null ? 0 : 1

  name                = "hca-${azurerm_function_app.this.name}"
  resource_group_name = var.resource_group_name

  enabled             = var.health_check_alert_enabled
  severity            = 1
  scopes              = [azurerm_function_app.this.id]
  description         = "Action will be triggered when health check fails."

  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace  = "Microsoft.Web/Sites"
    metric_name       = "HealthCheckStatus"
    operator          = "LessThan"
    aggregation       = "Average"
    threshold         = 100
  }

  action {
    action_group_id   = var.health_check_alert_action_group_id
  }

  tags                = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "func" {
  name                       = "diag-func-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  target_resource_id         = azurerm_function_app.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_retention_in_days
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "stor" {
  name                       = "diag-stor-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  target_resource_id         = azurerm_storage_account.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_retention_in_days
    }
  }
}
