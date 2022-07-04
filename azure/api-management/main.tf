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
    "ModuleId"      = "azure-api-management"
  }
}

resource "azurerm_api_management" "this" {
  name                          = "apim-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  publisher_name                = var.publisher_name
  publisher_email               = var.publisher_email
  sku_name                      = var.sku_name
  virtual_network_type          = var.virtual_network_type
  virtual_network_configuration {
    subnet_id = var.subnet_id
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

resource "azurerm_api_management_policy" "this" {
  count               = length(var.policies)

  api_management_id   = azurerm_api_management.this.id
  xml_content         = try(var.policies[count.index].xml_content, null)
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                            = "diag-apim-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  target_resource_id              = azurerm_api_management.this.id
  log_analytics_workspace_id      = var.log_analytics_workspace_id
  log_analytics_destination_type  = "AzureDiagnostics"

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_retention_in_days
    }
  }
  
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      log,
    ]
  }
}