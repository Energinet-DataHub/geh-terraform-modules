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
    "ModuleVersion" = "6.1.0"
    "ModuleId"      = "azure-key-vault-access-polity"
  }
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id            = var.key_vault_id
  tenant_id               = var.app_identity_tenant_id
  object_id               = var.app_identity_principal_id
  secret_permissions      = [
    "list",
    "get"
  ]
}