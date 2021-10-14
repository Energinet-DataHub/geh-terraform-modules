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
    "ModuleVersion" = "3.1.0"
    "ModuleId"      = "azure-service-bus-namespace"
  }
}

resource "azurerm_servicebus_namespace" "this" {
  name                = "sb-${lower(var.name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  tags                = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_servicebus_namespace_authorization_rule" "this" {
  count               = length(var.auth_rules)
 
  name                = try(var.auth_rules[count.index].name, null)
  namespace_name      = azurerm_servicebus_namespace.this.name
  resource_group_name = var.resource_group_name
  listen              = try(var.auth_rules[count.index].listen, false)
  send                = try(var.auth_rules[count.index].send, false)
  manage              = try(var.auth_rules[count.index].manage, false)
}