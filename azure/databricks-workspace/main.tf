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
}

resource "azurerm_databricks_workspace" "this" {
  name                = "dbw-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  custom_parameters {
    virtual_network_id  = module.vnet_this.id
    no_public_ip        = true
    public_subnet_name  = module.snet_databricks_public.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.nsg_public_group_association.id
    private_subnet_name = module.snet_databricks_private.name
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

  depends_on = [
    module.vnet_this
  ]
}

module "vnet_this" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/vnet?ref=6.0.0"
  name                  = "databricks-${var.domain_name_short}"
  project_name          = var.domain_name_short
  environment_short     = var.environment_short
  environment_instance  = var.environment_instance
  resource_group_name   = var.resource_group_name
  location              = var.location
  address_space         = [var.vnet_address_space]
  peerings              = [
    {
      name                                        = "peering-${var.main_virtual_network_name}"
      remote_virtual_network_id                   = var.main_virtual_network_id
      remote_virtual_network_name                 = var.main_virtual_network_name
      remote_virtual_network_resource_group_name  = var.main_resource_group_name
      remote_virtual_network_subscription_id      = var.subscription_id
    }
  ]
}

module "snet_private" {
  source                                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/subnet?ref=6.0.0"
  name                                          = "private"
  project_name                                  = var.domain_name_short
  environment_short                             = var.environment_short
  environment_instance                          = var.environment_instance
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = module.vnet_this.name
  address_prefixes                              = [var.private_subnet_address_prefix]
  enforce_private_link_service_network_policies = true

  # Delegate the subnet to "Microsoft.Databricks/workspaces"
  delegations =  [{
   name = "delegation"
   service_delegation_name    = "Microsoft.Databricks/workspaces"
   service_delegation_actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
    ]
  }]
}

module "snet_public" {
  source                                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/subnet?ref=6.0.0"
  name                                          = "public"
  project_name                                  = var.domain_name_short
  environment_short                             = var.environment_short
  environment_instance                          = var.environment_instance
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = module.vnet_this.name
  address_prefixes                              = [var.public_subnet_address_prefix]
  enforce_private_link_service_network_policies = true

  # Delegate the subnet to "Microsoft.Databricks/workspaces"
  delegations =  [{
   name = "delegation"
   service_delegation_name    = "Microsoft.Databricks/workspaces"
   service_delegation_actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
    ]
  }]
}

resource "azurerm_network_security_group" "dbw_nsg" {
  name                = "nsg-dbw-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

resource "azurerm_subnet_network_security_group_association" "nsg_public_group_association" {
  subnet_id                 = module.snet_databricks_public.id
  network_security_group_id = azurerm_network_security_group.dbw_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_private_group_association" {
  subnet_id                 = module.snet_databricks_private.id
  network_security_group_id = azurerm_network_security_group.dbw_nsg.id
}