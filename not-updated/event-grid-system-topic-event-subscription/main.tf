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
resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
  command = "echo ${length(var.dependencies)}"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [
    azurerm_eventgrid_system_topic_event_subscription.main,
  ]
}

resource "azurerm_eventgrid_system_topic_event_subscription" "main" {
  depends_on            = [null_resource.dependency_getter]
  name                  = "evgstes-${lower(var.name)}-${lower(var.project_name)}-${lower(var.organisation_name)}-${lower(var.environment_short)}"
  system_topic          = var.system_topic
  resource_group_name   = var.resource_group_name 
  included_event_types  = var.included_event_types
  storage_queue_endpoint {
    storage_account_id = var.storage_queue_endpoint.storage_account_id
    queue_name         = var.storage_queue_endpoint.name
  }
}