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
output "id" {
  value       = azurerm_service-bus_queue_authorization_rule.main.id
  description = "The ID of the Service Bus Topic Authorization Rule."
}

output "name" {
  value       = azurerm_service-bus_queue_authorization_rule.main.name
  description = "The name of the Service Bus Topic Authorization Rule."
}

output "dependent_on" {
  value = null_resource.dependency_setter.id
  description = "The dependencies of the Service Bus Topic Authorization Rule."
}

output "primary_connection_string" {
  value       = azurerm_service-bus_queue_authorization_rule.main.primary_connection_string
  description = "The Primary Connection String for the Service Bus Topic Authorization Rule."
  sensitive   = true
}