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
    azurerm_key_vault.main,
    azurerm_key_vault_access_policy.main,
  ]
}

data "azurerm_client_config" "main" {}

resource "azurerm_key_vault" "main" {
  depends_on          = [null_resource.dependency_getter]
  name                = "kv${lower(var.name)}${lower(var.project_name)}${lower(var.organisation_name)}${lower(var.environment_short)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.main.tenant_id
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_key_vault_access_policy" "selfpermissions" {
  depends_on    = [azurerm_key_vault.main]
  key_vault_id  = azurerm_key_vault.main.id
  tenant_id     = data.azurerm_client_config.main.tenant_id
  object_id     = data.azurerm_client_config.main.object_id

  secret_permissions      = ["delete", "list", "get", "set"]
  key_permissions         = ["create", "list", "delete", "get"]
  certificate_permissions = ["create", "list", "delete", "get"]
  storage_permissions     = ["delete", "get", "set"]
}

resource "azurerm_key_vault_access_policy" "main" {
  depends_on              = [azurerm_key_vault.main]
  count                   = length(var.access_policy)
  key_vault_id            = azurerm_key_vault.main.id
  tenant_id               = var.access_policy[count.index].tenant_id
  object_id               = var.access_policy[count.index].object_id
  secret_permissions      = var.access_policy[count.index].secret_permissions
  key_permissions         = var.access_policy[count.index].key_permissions
  certificate_permissions = var.access_policy[count.index].certificate_permissions
  storage_permissions     = var.access_policy[count.index].storage_permissions
}