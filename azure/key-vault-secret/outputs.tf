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
  value       = azurerm_key_vault_secret.this.id
  description = "The Key Vault Secret ID."
}

output name {
  value       = azurerm_key_vault_secret.this.name
  description = "The Key Vault Secret name."
}

output version {
  value       = azurerm_key_vault_secret.this.version
  description = "The current version of the Key Vault Secret."
}

output value {
  value       = var.value
  description = "The Key Vault Secret value."
  sensitive   = true
}
