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
    "ModuleId"      = "azure-function-app"
  }
}

resource "azurerm_storage_account" "this" {
  name                      = "st${random_string.this.result}"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
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

resource "azurerm_storage_account_network_rules" "this" {
  resource_group_name  = var.resource_group_name
  storage_account_name = azurerm_storage_account.this.name

  default_action             = "Deny"
  virtual_network_subnet_ids = [var.vnet_integration_subnet_id]
  ip_rules                   = [
    "127.0.0.1"
  ]

  bypass                     = [
    "Logging",
    "Metrics",
  ]
  depends_on = [
    azurerm_private_endpoint.this,
  ]
}

resource "azurerm_private_endpoint" "this" {
  name                = "pe-${lower(var.name)}${lower(var.project_name)}${lower(var.environment_short)}${lower(var.environment_instance)}"
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
    azurerm_storage_account.this,
  ]
}

# Create an A record pointing to the Storage Account private endpoint
resource "azurerm_private_dns_a_record" "this" {
  name                = azurerm_storage_account.this.name
  zone_name           = "privatelink.blob.core.windows.net"
  resource_group_name = var.private_dns_resource_group_name
  ttl                 = 3600
  records             = [azurerm_private_endpoint.this.private_service_connection[0].private_ip_address]
}

resource "random_string" "this" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  app_service_id = azurerm_function_app.this.id
  subnet_id      = var.vnet_integration_subnet_id
}

resource "azurerm_function_app" "this" {
  name                        = "func-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  app_service_plan_id         = var.app_service_plan_id
  storage_account_name        = azurerm_storage_account.this.name
  storage_account_access_key  = azurerm_storage_account.this.primary_access_key
  version                     = "~3"
  https_only                  = true
  app_settings                = merge({
    APPINSIGHTS_INSTRUMENTATIONKEY = var.application_insights_instrumentation_key
    WEBSITE_VNET_ROUTE_ALL                = "1"
    WEBSITE_CONTENTOVERVNET               = "1"
  },var.app_settings)
  identity {
    type = "SystemAssigned"
  }
  site_config {
    always_on = var.always_on
    cors {
      allowed_origins = ["*"]
    }
  }
  dynamic "connection_string" {
    for_each  = var.connection_strings
    content {
      name  = connection_strings.key
      value = connection_strings.value
      type  = "Custom"
    }
  }

  tags                        = merge(var.tags, local.module_tags)

  depends_on                  = [
    azurerm_storage_account.this,
  ]

  lifecycle {
    ignore_changes = [
      source_control,
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}
