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
    "ModuleId"      = "azure-mssql-server"
  }
}

data "azurerm_client_config" "this" {}

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

  azuread_administrator {
    azuread_authentication_only = var.ad_authentication_only

    login_username              = data.azurerm_client_config.this.client_id # TODO: Can we use Client ID or do we need login name?
    object_id                   = data.azurerm_client_config.this.object_id
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

  tags                 = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
      private_dns_zone_group,
    ]
  }
}

resource "random_string" "this" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "diag-mssql-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  target_resource_id         = azurerm_mssql_server.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_retention_in_days
    }
  }
}
