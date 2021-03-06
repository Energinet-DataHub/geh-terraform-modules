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
  value       = azurerm_api_management.this.id
  description = "The ID of the API Management Service."

  depends_on  = [
    azurerm_api_management.this,
    azurerm_api_management_policy.this,
    azurerm_monitor_diagnostic_setting.this,
  ]
}

output name {
  value       = azurerm_api_management.this.name
  description = "The name of the API Management Service."

  depends_on  = [
    azurerm_api_management.this,
    azurerm_api_management_policy.this,
    azurerm_monitor_diagnostic_setting.this,
  ]
}

output gateway_url {
  value       = azurerm_api_management.this.gateway_url
  description = "The URL of the Gateway for the API Management Service."

  depends_on  = [
    azurerm_api_management.this,
    azurerm_api_management_policy.this,
    azurerm_monitor_diagnostic_setting.this,
  ]
}