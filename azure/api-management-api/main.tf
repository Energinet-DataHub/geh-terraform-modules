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
    "ModuleVersion" = "5.0.0"
    "ModuleId"      = "azure-api-management-api"
  }
}

resource "azurerm_api_management_api" "this" {
  name                  = "apima-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = var.resource_group_name
  api_management_name   = var.api_management_name
  revision              = var.revision
  display_name          = var.display_name
  protocols             = var.protocols
  subscription_required = var.subscription_required
}

resource "azurerm_api_management_api_policy" "this" {
  count               = length(var.policies)

  api_name            = azurerm_api_management_api.this.name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name
  xml_content         = try(var.policies[count.index].xml_content, null)
}
