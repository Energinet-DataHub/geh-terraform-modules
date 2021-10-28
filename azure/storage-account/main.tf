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
    "ModuleVersion" = "4.1.0"
    "ModuleId"      = "azure-storage-account"
  }
}

resource "azurerm_storage_account" "this" {
  name                      = "st${lower(var.name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
  resource_group_name       = var.resource_group_name 
  location                  = var.location 
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  is_hns_enabled            = var.is_hns_enabled  
  min_tls_version           = "TLS1_2"

  tags                      = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_storage_container" "this" {
  count                 = length(var.containers)

  name                  = try(var.containers[count.index].name, null)
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = try(var.containers[count.index].access_type, "private")
}