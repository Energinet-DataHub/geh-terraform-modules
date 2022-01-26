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
  sku                 = var.sku
  capacity            = var.capacity
  tags                = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_servicebus_namespace_network_rule_set" "this" {
  namespace_id = azurerm_servicebus_namespace.this.id

  default_action = "Deny"
  ip_rules       = [
    "127.0.0.1"
  ]
}

resource "azurerm_servicebus_namespace_authorization_rule" "this" {
  count               = length(var.auth_rules)

  name                = try(var.auth_rules[count.index].name, null)
  namespace_id      = azurerm_servicebus_namespace.this.id
  listen              = try(var.auth_rules[count.index].listen, false)
  send                = try(var.auth_rules[count.index].send, false)
  manage              = try(var.auth_rules[count.index].manage, false)
}

resource "azurerm_private_endpoint" "this" {
   name                = "pe-${lower(var.name)}${lower(var.project_name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
   location            = var.location
   resource_group_name = var.resource_group_name
   subnet_id           = var.private_endpoint_subnet_id
   private_service_connection {
     name                           = "psc${lower(var.name)}${lower(var.project_name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
     private_connection_resource_id = azurerm_servicebus_namespace.this.id
     is_manual_connection           = false
     subresource_names              = ["namespace"]
  }
    depends_on = [
    azurerm_servicebus_namespace.this,
  ]
}

# Create an A record pointing to the namespace private endpoint
resource "azurerm_private_dns_a_record" "this" {
  name                = azurerm_servicebus_namespace.this.name
  zone_name           = "privatelink.servicebus.windows.net"
  resource_group_name = var.private_dns_resource_group_name
  ttl                 = 3600
  records             = [azurerm_private_endpoint.this.private_service_connection[0].private_ip_address]
}
