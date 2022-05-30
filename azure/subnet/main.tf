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
resource "azurerm_subnet" "this" {
  name                                            = "snet-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name                             = var.resource_group_name
  virtual_network_name                            = var.virtual_network_name
  address_prefixes                                = var.address_prefixes
  enforce_private_link_service_network_policies   = var.enforce_private_link_service_network_policies
  enforce_private_link_endpoint_network_policies  = var.enforce_private_link_endpoint_network_policies
  service_endpoints                               = var.service_endpoints

  dynamic "delegation" {
    for_each  = var.delegations
    content {
      name = delegation.value["name"]
  
      service_delegation {
        name    = delegation.value["service_delegation_name"]
        actions = delegation.value["service_delegation_actions"]
      }
    }
  }
}
