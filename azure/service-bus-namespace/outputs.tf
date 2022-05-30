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
output id {
  value       = azurerm_servicebus_namespace.this.id
  description = "The Service Bus Namespace ID."

  depends_on = [
    azurerm_servicebus_namespace_network_rule_set.this,
    azurerm_servicebus_namespace.this,
    azurerm_servicebus_namespace_authorization_rule.this,
    azurerm_private_endpoint.this,
  ]
}

output name {
  value       = azurerm_servicebus_namespace.this.name
  description = "The Service Bus Namespace name."

  depends_on = [
    azurerm_servicebus_namespace_network_rule_set.this,
    azurerm_servicebus_namespace.this,
    azurerm_servicebus_namespace_authorization_rule.this,
    azurerm_private_endpoint.this,
  ]
}

output primary_connection_strings {
  value       = { for instance in azurerm_servicebus_namespace_authorization_rule.this: instance.name => instance.primary_connection_string }
  description = "A list of Auth Rule connection strings"

  depends_on = [
    azurerm_servicebus_namespace_network_rule_set.this,
    azurerm_servicebus_namespace.this,
    azurerm_servicebus_namespace_authorization_rule.this,
    azurerm_private_endpoint.this,
  ]
}