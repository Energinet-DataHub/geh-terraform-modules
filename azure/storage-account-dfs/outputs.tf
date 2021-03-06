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
  value       = azurerm_storage_account.this.id
  description = "The ID of the Storage Account"

  depends_on  = [
    azurerm_storage_account.this,
    azurerm_private_endpoint.dfs,
    azurerm_private_dns_a_record.dfs,
    azurerm_monitor_diagnostic_setting.this,
  ]
}

output name {
  value       = azurerm_storage_account.this.name
  description = "The name of the Storage Account."

  depends_on  = [
    azurerm_storage_account.this,
    azurerm_private_endpoint.dfs,
    azurerm_private_dns_a_record.dfs,
    azurerm_monitor_diagnostic_setting.this,
  ]
}

output primary_connection_string {
  value       = azurerm_storage_account.this.primary_connection_string
  description = "The connection string associated with the primary location."
  sensitive   = true

  depends_on  = [
    azurerm_storage_account.this,
    azurerm_private_endpoint.dfs,
    azurerm_private_dns_a_record.dfs,
    azurerm_monitor_diagnostic_setting.this,
  ]
}

output primary_access_key {
  value       = azurerm_storage_account.this.primary_access_key
  description = "The primary access key for the storage account."
  sensitive   = true

  depends_on  = [
    azurerm_storage_account.this,
    azurerm_private_endpoint.dfs,
    azurerm_private_dns_a_record.dfs,
    azurerm_monitor_diagnostic_setting.this,
  ]
}
