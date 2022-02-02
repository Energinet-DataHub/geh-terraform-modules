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
    "ModuleId"      = "azure-mssql-server"
  }
}

resource "azurerm_mssql_server" "this" {
  name                          = "mssql-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.sql_version
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  public_network_access_enabled = false
  identity {
    type  = "SystemAssigned" 
  }

  tags                          = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
  
  depends_on                    = [
    var.private_endpoint_subnet_id
  ]
}

resource "azurerm_private_endpoint" "this" {
   name                = "pe-${lower(var.name)}${random_string.this.result}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
   location            = var.location
   resource_group_name = var.resource_group_name
   subnet_id           = var.private_endpoint_subnet_id
   private_service_connection {
    name                            = "psc-01"
    private_connection_resource_id  = azurerm_mssql_server.this.id
    is_manual_connection            = false
    subresource_names               = [
       "sqlServer"
    ]
  }
}

resource "random_string" "this" {
  length  = 5
  special = false
  upper   = false
}

# Create an A record pointing to the Azure SQL database private endpoint
resource "azurerm_private_dns_a_record" "this" {
  name                = azurerm_mssql_server.this.name
  zone_name           = "privatelink.database.windows.net"
  resource_group_name = var.private_dns_resource_group_name
  ttl                 = 3600
  records             = [
    azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
  ]
}