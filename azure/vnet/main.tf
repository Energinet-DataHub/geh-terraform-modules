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
    "ModuleVersion" = "6.0.0",
    "ModuleId"      = "azure-vnet"
  }
}

locals {
  NAME = "vnet-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
}

resource "azurerm_virtual_network" "this" {
  name                = local.NAME
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space       = var.address_space

  tags                = var.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_virtual_network_peering" "local" {
  count                         = length(var.peerings)

  name                          = "${local.NAME}-to-${lower(try(var.peerings[count.index].name, null))}"
  resource_group_name           = var.resource_group_name
  virtual_network_name          = azurerm_virtual_network.this.name
  remote_virtual_network_id     = try(var.peerings[count.index].remote_virtual_network_id, null)
  allow_virtual_network_access  = true
}

resource "azurerm_virtual_network_peering" "remote" {
  count                         = length(var.peerings)

  name                          = "test_remote"
  #"${lower(try(var.peerings[count.index].name, null))}-to-${local.NAME}"
  resource_group_name           = "test"
  virtual_network_name          = try(var.peerings[count.index].remote_virtual_network_id, null)
  remote_virtual_network_id     = "/subscriptions/${try(var.peerings[count.index].remote_virtual_network_subscription_id, null)}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${azurerm_virtual_network.this.name}"
  allow_virtual_network_access  = true
}