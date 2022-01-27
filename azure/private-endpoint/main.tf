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
    "ModuleId"      = "azure-private-endpoint"
  }
}

resource "azurerm_private_endpoint" "this" {
   name                = "pe-${lower(var.name)}${lower(var.project_name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
   location            = var.location
   resource_group_name = var.resource_group_name
   subnet_id           = var.private_endpoint_subnet_id
   private_service_connection {
     name                           = "psc-${lower(var.name)}${lower(var.project_name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
     private_connection_resource_id = var.resource_id
     is_manual_connection           = false
     subresource_names              = [var.resource_type]
  }
}

# Create an A record pointing to the private endpoint
resource "azurerm_private_dns_a_record" "this" {
  name                = var.resource_name
  zone_name           = var.zone_name
  resource_group_name = var.vnet_resource_group_name
  ttl                 = 3600
  records             = [azurerm_private_endpoint.this.private_service_connection[0].private_ip_address]
}

