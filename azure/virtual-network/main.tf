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
    azurerm_virtual_network.this,
    azurerm_subnet.this,
  ]
}

locals {
  module_tags = {
    "ModuleVersion" = "3.1.0",
    "ModuleId"      = "azure-virtual-network"
  }
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.name}-${var.environment_short}-${var.environment_instance}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge(var.tags, local.module_tags)

  address_space = var.address_spaces
  dns_servers   = var.dns_servers

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan_id == null ? [] : [1]
    content {
      id     = var.ddos_protection_plan_id
      enable = true 
    }
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_subnet" "this" {
  depends_on = [
    azurerm_virtual_network.this
  ]
  for_each             = var.subnets
  name                 = each.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.address_prefixes

  # TODO extend with further functionality https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
}
