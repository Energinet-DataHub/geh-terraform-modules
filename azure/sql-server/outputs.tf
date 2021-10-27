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
  value       = azurerm_sql_server.this.id
  description = "The Microsoft SQL Server ID."
}

output name {
  value       = azurerm_sql_server.this.name
  description = "The Microsoft SQL Server name."
}

output fully_qualified_domain_name {
  value       = azurerm_sql_server.this.fully_qualified_domain_name
  description = "The fully qualified domain name of the Azure SQL Server (e.g. myServerName.database.windows.net)"
}

output identity_principal_id {
  value       = azurerm_sql_server.this.identity.0.principal_id
  description = "The Principal ID for the Service Principal associated with the Identity of this SQL Server."
}

output identity_tenant_id {
  value       = azurerm_sql_server.this.identity.0.tenant_id
  description = "The Tenant ID for the Service Principal associated with the Identity of this SQL Server."
}
