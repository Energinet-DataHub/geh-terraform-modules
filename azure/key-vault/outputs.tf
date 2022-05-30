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
  value       = azurerm_key_vault.this.id
  description = "The ID of the Key Vault."

  depends_on  = [
    azurerm_key_vault.this,
    azurerm_key_vault_access_policy.selfpermissions,
    azurerm_key_vault_access_policy.this,
    azurerm_private_endpoint.this,
  ]
}

output name {
  value       = azurerm_key_vault.this.name
  description = "The name of the Key Vault."

  depends_on  = [
    azurerm_key_vault.this,
    azurerm_key_vault_access_policy.selfpermissions,
    azurerm_key_vault_access_policy.this,
    azurerm_private_endpoint.this,
  ]
}

output vault_uri {
  value       = azurerm_key_vault.this.vault_uri
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."

  depends_on  = [
    azurerm_key_vault.this,
    azurerm_key_vault_access_policy.selfpermissions,
    azurerm_key_vault_access_policy.this,
    azurerm_private_endpoint.this,
  ]
}