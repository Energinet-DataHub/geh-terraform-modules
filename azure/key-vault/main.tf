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
    azurerm_key_vault.this,
    azurerm_key_vault_access_policy.selfpermissions,
    azurerm_key_vault_access_policy.this,
  ]
}

locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-key-vault"
  }
}

data "azurerm_client_config" "this" {}

resource "azurerm_key_vault" "this" {
  name                            = "kv-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = data.azurerm_client_config.this.tenant_id
  sku_name                        = var.sku_name
  enabled_for_template_deployment = true

  tags                            = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
  network_acls {
    default_action = "Deny"
    ip_rules                   = [
    "127.0.0.1"
  ]
  }
}

resource "azurerm_private_endpoint" "this" {
   name                = "pe${lower(var.name)}${lower(var.project_name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
   location            = var.location
   resource_group_name = var.resource_group_name
   subnet_id           = var.private_endpoint_subnet_id
   private_service_connection {
     name                           = "psc${lower(var.name)}${lower(var.project_name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
     private_connection_resource_id = azurerm_key_vault.this.id
     is_manual_connection           = false
     subresource_names              = ["Vault"]
  }
}

# Create an A record pointing to the keyvalut private endpoint
resource "azurerm_private_dns_a_record" "this" {
  name                = azurerm_key_vault.this.name
  zone_name           = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = 3600
  records             = [azurerm_private_endpoint.this.private_service_connection[0].private_ip_address]
}


resource "azurerm_key_vault_access_policy" "selfpermissions" {
  key_vault_id            = azurerm_key_vault.this.id
  tenant_id               = data.azurerm_client_config.this.tenant_id
  object_id               = data.azurerm_client_config.this.object_id
  secret_permissions      = ["delete", "list", "get", "set", "purge"]
  key_permissions         = ["create", "list", "delete", "get"]
  certificate_permissions = ["create", "list", "delete", "get"]
  storage_permissions     = ["delete", "get", "set"]
}

resource "azurerm_key_vault_access_policy" "this" {
  count                   = length(var.access_policies)

  key_vault_id            = azurerm_key_vault.this.id
  tenant_id               = data.azurerm_client_config.this.tenant_id
  object_id               = data.azurerm_client_config.this.object_id
  secret_permissions      = try(var.access_policies[count.index].secret_permissions, [])
  key_permissions         = try(var.access_policies[count.index].key_permissions, [])
  certificate_permissions = try(var.access_policies[count.index].certificate_permissions, [])
  storage_permissions     = try(var.access_policies[count.index].storage_permissions, [])
}