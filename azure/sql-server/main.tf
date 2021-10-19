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
resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [
    azurerm_sql_server.this,
  ]
}

locals {
  module_tags = {
    "ModuleVersion" = "3.1.0"
    "ModuleId"      = "azure-sql-server"
  }
}

resource "azurerm_sql_server" "this" {
  name                          = "sql-${lower(var.name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.sql_version
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  identity {
    type  = "SystemAssigned" 
  }

  tags                          = merge(var.tags, local.module_tags)

  depends_on                    = [
    null_resource.dependency_getter,
  ]

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_sql_firewall_rule" "this" {
  count               = length(var.firewall_rules)

  name                = "${lower(try(var.firewall_rules[count.index].start_ip_address, null))}-${lower(var.name)}-${lower(var.environment_short)}-${var.environment_instance}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.this.name
  start_ip_address    = try(var.firewall_rules[count.index].start_ip_address, null)
  end_ip_address      = try(var.firewall_rules[count.index].end_ip_address, null)

  depends_on          = [
    null_resource.dependency_getter,
  ]
}
