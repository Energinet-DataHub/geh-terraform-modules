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
      name = connection_string.value.name
      type = connection_string.value.type
      value = connection_string.value.value
    }
  }

  tags                        = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      source_control,
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

#
# Function App integrated into VNet
#

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  app_service_id = azurerm_function_app.this.id
  subnet_id      = var.vnet_integration_subnet_id
}

#
# Private Endpoint for Azure Function
#

resource "random_string" "this" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_private_endpoint" "this" {
  name                = "pe-${lower(var.name)}${random_string.this.result}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.external_private_endpoint_subnet_id

  private_service_connection {
    name                           = "pcs-01"
    private_connection_resource_id = azurerm_function_app.this.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  tags                             = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }

  depends_on = [
    azurerm_function_app.this
  ]
}

# Create an A record pointing to the Azure Function App private endpoint
resource "azurerm_private_dns_a_record" "this" {
  name                = azurerm_function_app.this.name
  zone_name           = "privatelink.azurewebsites.net"
  resource_group_name = var.private_dns_resource_group_name
  ttl                 = 3600
  records             = [
    azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
  ]
  
  depends_on          = [
    time_sleep.this,
  ]
}

resource "random_string" "st" {
  length  = 10
  special = false
  upper   = false
}

# If using private endpoint connections, the storage account will need a private endpoint for the
# 'file' and 'blob' sub-resources. If using certain capabilities like Durable Functions, you will also
# need 'queue' and 'table' accessible through a private endpoint connection.
resource "azurerm_storage_account" "this" {
  name                      = "st${random_string.st.result}"
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
  storage_account_id          = azurerm_storage_account.this.id

  default_action              = "Deny"
  ip_rules                    = [
    "127.0.0.1"
  ]
  bypass                      = [
    "Logging",
    "Metrics",
  ]
}

#
# Private Endpoint for Blob subresource
#

resource "random_string" "blob" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_private_endpoint" "blob" {
  name                = "pe-${lower(var.name)}${random_string.blob.result}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "pcs-01"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags                             = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }

  depends_on = [
    azurerm_private_endpoint.file
  ]
}

# Create an A record pointing to the Storage Account (blob) private endpoint
resource "azurerm_private_dns_a_record" "blob" {
  name                = azurerm_storage_account.this.name
  zone_name           = "privatelink.blob.core.windows.net"
  resource_group_name = var.private_dns_resource_group_name
  ttl                 = 3600
  records             = [
    azurerm_private_endpoint.blob.private_service_connection[0].private_ip_address
  ]
    
  depends_on          = [
    time_sleep.this,
  ]
}

#
# Private Endpoint for file subresource
#

resource "random_string" "file" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_private_endpoint" "file" {
  name                = "pe-${lower(var.name)}${random_string.file.result}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "pcs-01"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }

  tags                             = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

# Create an A record pointing to the Storage Account (file) private endpoint
resource "azurerm_private_dns_a_record" "file" {
  name                = azurerm_storage_account.this.name
  zone_name           = "privatelink.file.core.windows.net"
  resource_group_name = var.private_dns_resource_group_name
  ttl                 = 3600
  records             = [
    azurerm_private_endpoint.file.private_service_connection[0].private_ip_address
  ]
    
  depends_on          = [
    time_sleep.this,
  ]
}

# Waiting for the private endpoint to come online
resource "time_sleep" "this" {
  depends_on = [
    azurerm_private_endpoint.this
  ]

  create_duration = "60s"
}
