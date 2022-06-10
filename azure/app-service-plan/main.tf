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
    "ModuleId"      = "azure-app-service-plan"
  }
}

resource "azurerm_app_service_plan" "this" {
  name                = "plan-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = var.kind
  reserved            = var.reserved

  sku {
    size = var.sku.size
    tier = var.sku.tier
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

resource "azurerm_monitor_metric_alert" "metric_alert_cpu" {
  name                = "ma-${azurerm_app_service_plan.this.name}-cpu"
  resource_group_name = var.resource_group_name

  enabled             = var.monitor_alerts_enabled
  severity            = 2
  scopes              = [azurerm_app_service_plan.this.id]
  description         = "Action will be triggered when average CPU usage is too high."

  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace  = "Microsoft.Web/ServerFarms"
    metric_name       = "CpuPercentage"
    operator          = "GreaterThan"
    aggregation       = "Average"
    threshold         = 80
  }

  action {
    action_group_id   = var.monitor_alerts_action_group_id
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

resource "azurerm_monitor_metric_alert" "metric_alert_memory" {
  name                = "ma-${azurerm_app_service_plan.this.name}-mry"
  resource_group_name = var.resource_group_name

  enabled             = var.monitor_alerts_enabled
  severity            = 2
  scopes              = [azurerm_app_service_plan.this.id]
  description         = "Action will be triggered when average memory usage is too high."

  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace  = "Microsoft.Web/ServerFarms"
    metric_name       = "MemoryPercentage"
    operator          = "GreaterThan"
    aggregation       = "Average"
    threshold         = 80
  }

  action {
    action_group_id   = var.monitor_alerts_action_group_id
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
