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
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-service-bus-namespace"
  }
}

resource "azurerm_servicebus_namespace" "this" {
  name                = "sb-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Premium"
  capacity            = var.capacity

  tags                = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }

  depends_on          = [
    var.private_endpoint_subnet_id
  ]
}

resource "azurerm_servicebus_namespace_network_rule_set" "this" {
  namespace_id = azurerm_servicebus_namespace.this.id

  public_network_access_enabled = false
}

resource "azurerm_servicebus_namespace_authorization_rule" "this" {
  count               = length(var.auth_rules)

  name                = try(var.auth_rules[count.index].name, null)
  namespace_id        = azurerm_servicebus_namespace.this.id
  listen              = try(var.auth_rules[count.index].listen, false)
  send                = try(var.auth_rules[count.index].send, false)
  manage              = try(var.auth_rules[count.index].manage, false)
}

resource "random_string" "this" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_private_endpoint" "this" {
  name                = "pe-${lower(var.name)}${random_string.this.result}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                            = "psc-01"
    private_connection_resource_id  = azurerm_servicebus_namespace.this.id
    is_manual_connection            = false
    subresource_names               = ["namespace"]
  }

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
  count                      = (var.log_analytics_workspace_id == null ? 0 : 1)
  name                       = "diag-sb-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  target_resource_id         = azurerm_servicebus_namespace.this.id
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
