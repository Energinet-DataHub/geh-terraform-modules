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
output "webtest_id" {
  value = azurerm_application_insights_web_test.main.id
}

output "webtests_synthetic_id" {
  value = azurerm_application_insights_web_test.main.synthetic_monitor_id
}

output "name" {
  value = azurerm_application_insights_web_test.main.name
}

output "dependent_on" {
  value       = null_resource.dependency_setter.id
  description = "The dependencies of the resource created."
}