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
resource "null_resource" "dependency_setter" {
  depends_on = [
    azurerm_storage_account.this,
    azurerm_storage_container.this,
  ]
}

locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-storage-account"
  }
}

resource "azurerm_storage_account" "this" {
  name                      = "st${lower(var.name)}${lower(var.project_name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
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

#please note that this https://github.com/hashicorp/terraform-provider-azurerm/pull/14220 might be an issue until it is fixed
resource "azurerm_storage_container" "this" {
  count                 = length(var.containers)

  name                  = try(var.containers[count.index].name, null)
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = try(var.containers[count.index].access_type, "private")
}

resource "azurerm_private_endpoint" "this" {
   name                = "pe${lower(var.name)}${lower(var.project_name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
   location            = var.location
   resource_group_name = var.resource_group_name
   subnet_id           = var.private_endpoint_subnet_id
   private_service_connection {
     name                           = "psc${lower(var.name)}${lower(var.project_name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
     private_connection_resource_id = azurerm_storage_account.this.id
     is_manual_connection           = false
     subresource_names              = ["blob"]
  }
    depends_on = [
    azurerm_storage_container.this,
  ]
}

# Create the blob.core.windows.net Private DNS Zone
resource "azurerm_private_dns_zone" "this" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}

# Create an A record pointing to the Storage Account private endpoint
resource "azurerm_private_dns_a_record" "this" {
  name                = azurerm_storage_account.this.name
  zone_name           = azurerm_private_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = 3600
  records             = [azurerm_private_endpoint.this.private_service_connection[0].private_ip_address]
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "${azurerm_storage_account.this.name}link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = var.vnet_id
}