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
    "ModuleVersion" = "5.6.0"
    "ModuleId"      = "azure-mssql-database"
  }
}

resource "azurerm_mssql_database" "this" {
  name                          = "mssqldb-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  server_id                     = var.server_id
  sku_name                      = var.sku_name
  min_capacity                  = var.min_capacity
  auto_pause_delay_in_minutes   = var.auto_pause_delay_in_minutes

  tags                              = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "vault-log-analytics-diagnostic-setting"
  target_resource_id         = azurerm_mssql_database.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  log {
    category = "AuditEvent"
    enabled  = true
    retention_policy {
      enabled = true
    }
  }
  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      enabled = true
    }
  }
}