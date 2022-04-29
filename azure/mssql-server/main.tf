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
    "ModuleVersion" = "5.7.0"
    "ModuleId"      = "azure-mssql-server"
  }
}

resource "azurerm_mssql_server" "this" {
  name                          = "mssql-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.sql_version
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  identity {
    type  = "SystemAssigned" 
  }

  tags                          = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_mssql_firewall_rule" "this" {
  count               = length(var.firewall_rules)

  name                = "${lower(try(var.firewall_rules[count.index].start_ip_address, null))}-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${var.environment_instance}"
  server_id           = azurerm_mssql_server.this.id
  start_ip_address    = try(var.firewall_rules[count.index].start_ip_address, null)
  end_ip_address      = try(var.firewall_rules[count.index].end_ip_address, null)
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "diag-mssql-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  target_resource_id         = azurerm_mssql_server.this.id
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

resource "azurerm_mssql_elasticpool" "this" {
  name                = "mssqlpool-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = azurerm_mssql_server.this.name
  license_type        = "LicenseIncluded"
  max_size_gb         = var.elastic_pool_max_size_gb

  sku {
    name      = var.elastic_pool_sku.name
    tier      = var.elastic_pool_sku.tier
    family    = var.elastic_pool_sku.family
    capacity  = var.elastic_pool_sku.capacity
  }

  per_database_settings {
    min_capacity = 0.25
    max_capacity = 4
  }
}