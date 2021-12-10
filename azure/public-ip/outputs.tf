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

output "id" {
  value       = azurerm_public_ip.this.id
  description = "The public ip id."
}

output "name" {
  value       = azurerm_public_ip.this.name
  description = "The public ip name."
}

output "ip_address" {
  value       = azurerm_public_ip.this.ip_address
  description = "The allocated ip address."
}

output "fqdn" {
  value       = azurerm_public_ip.this.fqdn
  description = "The fqdn if defined."
}
