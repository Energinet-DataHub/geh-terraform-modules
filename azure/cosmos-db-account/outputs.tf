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
  value       = azurerm_cosmosdb_account.this.id
  description = "The Cosmos DB Account ID."

  depends_on = [
    azurerm_cosmosdb_account.this,
    azurerm_private_endpoint.cosmos_sql,
    azurerm_private_dns_a_record.cosmosdb_sql_global,
    azurerm_private_dns_a_record.cosmosdb_sql_region,
  ]
}

output "name" {
  value       = azurerm_cosmosdb_account.this.name
  description = "The Cosmos DB Account name."

  depends_on = [
    azurerm_cosmosdb_account.this,
    azurerm_private_endpoint.cosmos_sql,
    azurerm_private_dns_a_record.cosmosdb_sql_global,
    azurerm_private_dns_a_record.cosmosdb_sql_region,
  ]
}

output "endpoint" {
  value       = azurerm_cosmosdb_account.this.endpoint
  description = "The Cosmos DB Account endpoint."

  depends_on = [
    azurerm_cosmosdb_account.this,
    azurerm_private_endpoint.cosmos_sql,
    azurerm_private_dns_a_record.cosmosdb_sql_global,
    azurerm_private_dns_a_record.cosmosdb_sql_region,
  ]
}

output "primary_key" {
  value       = azurerm_cosmosdb_account.this.primary_key
  description = "The Cosmos DB Account primary key."

  depends_on = [
    azurerm_cosmosdb_account.this,
    azurerm_private_endpoint.cosmos_sql,
    azurerm_private_dns_a_record.cosmosdb_sql_global,
    azurerm_private_dns_a_record.cosmosdb_sql_region,
  ]
}
