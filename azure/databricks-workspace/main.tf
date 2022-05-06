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
    "ModuleId"      = "azure-databricks-workspace"
  }
  NAME = "vnet-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
}

resource "azurerm_databricks_workspace" "this" {
  name                = "dbw-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  custom_parameters {
    virtual_network_id                                    = azurerm_virtual_network.this.id
    public_subnet_name                                    = azurerm_subnet.public.name
    public_subnet_network_security_group_association_id   = azurerm_subnet_network_security_group_association.nsg_public_group_association.id
    private_subnet_name                                   = azurerm_subnet.private.name
    private_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.nsg_private_group_association.id
  }

  tags                = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_virtual_network" "this" {
  name                = local.NAME
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.databricks_virtual_network_address_space]

  tags                = var.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_subnet" "private" {
  name                                            = "snet-private-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name                             = var.resource_group_name
  virtual_network_name                            = azurerm_virtual_network.this.name
  address_prefixes                                = [var.private_subnet_address_prefix]
  enforce_private_link_service_network_policies   = true
  enforce_private_link_endpoint_network_policies  = true
  delegation {
    name = "databricks-delegation"

    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
    }
  }
}

resource "azurerm_subnet" "public" {
  name                                            = "snet-public-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name                             = var.resource_group_name
  virtual_network_name                            = azurerm_virtual_network.this.name
  address_prefixes                                = [var.public_subnet_address_prefix]
  enforce_private_link_service_network_policies   = true
  enforce_private_link_endpoint_network_policies  = true
  delegation {
    name = "databricks-delegation"

    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_public_group_association" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.dbw_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_private_group_association" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.dbw_nsg.id
}

resource "azurerm_network_security_group" "dbw_nsg" {
  name                = "nsg-dbw-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_virtual_network_peering" "local" {
  name                          = "${local.NAME}-to-${var.main_virtual_network_name}"
  remote_virtual_network_id     = var.main_virtual_network_id
  virtual_network_name          = azurerm_virtual_network.this.name
  resource_group_name           = azurerm_virtual_network.this.resource_group_name
  allow_virtual_network_access  = true
}

resource "azurerm_virtual_network_peering" "remote" {
  name                          = "${var.main_virtual_network_name}-to-${local.NAME}"
  remote_virtual_network_id     = azurerm_virtual_network.this.id
  virtual_network_name          = var.main_virtual_network_name
  resource_group_name           = var.main_virtual_network_resource_group_name
  allow_virtual_network_access  = true
}

# Create a Private DNS Zone for Data Lake File System Gen2 (DFS) resources
resource "azurerm_private_dns_zone" "dfs" {
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = var.resource_group_name

  tags                = var.tags
}

# The Private DNS Zone for DFS must be linked with the Databricks dedicated virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "dfs" {
  name                  = "pdnsz-dfs-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dfs.name
  virtual_network_id    = azurerm_virtual_network.this.id

  tags                  = var.tags
}

# Create a Private DNS Zone for Blob resources
resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name

  tags                = var.tags
}

# The Private DNS Zone for Blob must be linked with the Databricks dedicated virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = "pdnsz-blob-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = azurerm_virtual_network.this.id

  tags                  = var.tags
}