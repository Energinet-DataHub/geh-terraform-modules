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
  value       = azurerm_application_insights.this.id
  description = "The ID of the Application Insights component."
}

output name {
  value       = azurerm_application_insights.this.name
  description = "The name of the Application Insights component."
}

output instrumentation_key {
  value       = azurerm_application_insights.this.instrumentation_key
  description = "The Instrumentation Key for this Application Insights component."
  sensitive   = true
}