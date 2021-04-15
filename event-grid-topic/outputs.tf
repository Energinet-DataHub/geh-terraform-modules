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
  value       = azurerm_eventgrid_topic.main.id
  description = "The EventGrid Topic ID."
}

output endpoint {
  value = azurerm_eventgrid_topic.main.endpoint
  description = " The Endpoint associated with the EventGrid Topic."
}

output "primary_access_key" {
  value       = azurerm_eventgrid_topic.main.primary_access_key
  description = "The Primary Shared Access Key associated with the EventGrid Topic."
  sensitive   = true
}

output "secondary_access_key" {
  value       = azurerm_eventgrid_topic.main.secondary_access_key
  description = "The Secondary Shared Access Key associated with the EventGrid Topic."
}

output "dependent_on" {
  value       = null_resource.dependency_setter.id
  description = "The dependencies of the Event Grid Topic component."
}