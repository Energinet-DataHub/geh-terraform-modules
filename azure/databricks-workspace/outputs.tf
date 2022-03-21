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
  value       = azurerm_databricks_workspace.this.id
  description = "The Databricks ID."
  
  depends_on = [
    azurerm_databricks_workspace.this,
    azurerm_virtual_network.this,
    azurerm_subnet.private,
    azurerm_subnet.public,
    azurerm_subnet_network_security_group_association.nsg_public_group_association,
    azurerm_subnet_network_security_group_association.nsg_private_group_association,
    azurerm_network_security_group.dbw_nsg,
    azurerm_virtual_network_peering.local,
    azurerm_virtual_network_peering.remote
  ]
}

output "location" {
  value       = azurerm_databricks_workspace.this.location
  description = "The location of the Databricks workspace."
  
  depends_on = [
    azurerm_databricks_workspace.this,
    azurerm_virtual_network.this,
    azurerm_subnet.private,
    azurerm_subnet.public,
    azurerm_subnet_network_security_group_association.nsg_public_group_association,
    azurerm_subnet_network_security_group_association.nsg_private_group_association,
    azurerm_network_security_group.dbw_nsg,
    azurerm_virtual_network_peering.local,
    azurerm_virtual_network_peering.remote
  ]
}

output "workspace_url" {
  value       = azurerm_databricks_workspace.this.workspace_url
  description = "The Databricks workspace URL."
  
  depends_on = [
    azurerm_databricks_workspace.this,
    azurerm_virtual_network.this,
    azurerm_subnet.private,
    azurerm_subnet.public,
    azurerm_subnet_network_security_group_association.nsg_public_group_association,
    azurerm_subnet_network_security_group_association.nsg_private_group_association,
    azurerm_network_security_group.dbw_nsg,
    azurerm_virtual_network_peering.local,
    azurerm_virtual_network_peering.remote
  ]
}
