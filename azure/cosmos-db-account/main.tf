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
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-cosmos-db-account"
  }
}

resource "azurerm_cosmosdb_account" "this" {
  name                = "cosmos-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  # To enable global failover change to true and uncomment second geo_location
  enable_automatic_failover         = false

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  tags                = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }

  depends_on          = [
    var.private_endpoint_subnet_id
  ]
}

#
# Private Endpoint for SQL subresource
#

resource "random_string" "cosmos_sql" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_private_endpoint" "cosmos_sql" {
  name                = "pe-${lower(var.name)}${random_string.cosmos_sql.result}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    is_manual_connection            = false
    name                            = "psc-01"
    private_connection_resource_id  = azurerm_cosmosdb_account.this.id
    subresource_names               = ["sql"]
  }

  tags                              = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

# # Create A records pointing to the Cosmos SQL private endpoint.
# # Multiple DNS records will be created as Cosmos must have a global FQDN and a local per region.
# resource "azurerm_private_dns_a_record" "cosmosdb_sql" {
#   count               = length(azurerm_private_endpoint.cosmos_sql.custom_dns_configs)

#   name                = split(".", azurerm_private_endpoint.cosmos_sql.custom_dns_configs[count.index].fqdn)[0]
#   zone_name           = "privatelink.documents.azure.com"
#   resource_group_name = var.private_dns_resource_group_name
#   ttl                 = 3600

#   records             = azurerm_private_endpoint.cosmos_sql.custom_dns_configs[count.index].ip_addresses
# }

# Create A records pointing to the Cosmos SQL private endpoint.
# Multiple DNS records will be created as Cosmos must have a global FQDN and a local per region.
resource "azurerm_private_dns_a_record" "cosmosdb_sql_global" {
  name                = split(".", azurerm_private_endpoint.cosmos_sql.custom_dns_configs[0].fqdn)[0]
  zone_name           = "privatelink.documents.azure.com"
  resource_group_name = var.private_dns_resource_group_name
  ttl                 = 3600

  records             = azurerm_private_endpoint.cosmos_sql.custom_dns_configs[0].ip_addresses

  depends_on = [
    azurerm_private_endpoint.cosmos_sql
  ]
}

resource "azurerm_private_dns_a_record" "cosmosdb_sql_region" {
  name                = split(".", azurerm_private_endpoint.cosmos_sql.custom_dns_configs[1].fqdn)[0]
  zone_name           = "privatelink.documents.azure.com"
  resource_group_name = var.private_dns_resource_group_name
  ttl                 = 3600

  records             = azurerm_private_endpoint.cosmos_sql.custom_dns_configs[1].ip_addresses

  depends_on = [
    azurerm_private_endpoint.cosmos_sql
  ]
}