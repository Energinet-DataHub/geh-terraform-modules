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
    azurerm_api_management_api_operation_policy.this,
  ]
}

locals {
  module_tags = {
    "ModuleVersion" = "3.1.0"
    "ModuleId"      = "api-management-api-operation"
  }
}

resource "azurerm_api_management_api_operation" "this" {
  operation_id        = lower(var.operation_id)
  api_name            = var.api_management_api_name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name
  display_name        = var.display_name
  method              = var.method
  url_template        = var.url_template

  depends_on          = [
    null_resource.dependency_getter,
  ]
}

resource "azurerm_api_management_api_operation_policy" "this" {
  count               = length(var.policies)

  api_name            = var.api_management_api_name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name
  operation_id        = azurerm_api_management_api_operation.this.operation_id
  xml_content         = try(var.policies[count.index].xml_content, null)

  depends_on          = [
    azurerm_api_management_api_operation.this,
  ]
}