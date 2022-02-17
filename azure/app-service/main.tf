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
    "ModuleVersion" = "7.0.0",
    "ModuleId"      = "azure-app-service"
  }
}

resource "azurerm_app_service" "this" {
  name                        = "app-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  app_service_plan_id         = var.app_service_plan_id
  https_only                  = true

  app_settings                = merge({
    APPINSIGHTS_INSTRUMENTATIONKEY = var.application_insights_instrumentation_key
    WEBSITE_VNET_ROUTE_ALL         = "1"
    WEBSITE_CONTENTOVERVNET        = "1"
  }, var.app_settings)

  identity {
    type = "SystemAssigned"
  }

  site_config {
    linux_fx_version = var.linux_fx_version
    dotnet_framework_version = var.dotnet_framework_version
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
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

#
# App Service integrated into VNet
#

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  app_service_id = azurerm_app_service.this.id
  subnet_id      = var.vnet_integration_subnet_id
}

#
# Private Endpoint for App Service
#

resource "random_string" "this" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_private_endpoint" "this" {
  count               = length(var.external_private_endpoint_subnet_id) > 0 ? 1 : 0

  name                = "pe-${lower(var.name)}${random_string.this.result}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.external_private_endpoint_subnet_id

  private_service_connection {
    name                           = "pcs-01"
    private_connection_resource_id = azurerm_app_service.this.id
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
    azurerm_app_service.this
  ]
}

# Create an A record pointing to the App service private endpoint
resource "azurerm_private_dns_a_record" "this" {
  name                = azurerm_app_service.this.name
  zone_name           = "privatelink.azurewebsites.net"
  resource_group_name = var.private_dns_resource_group_name
  ttl                 = 3600
  records             = [
    azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
  ]
  
  depends_on          = [
    time_sleep.this,
    azurerm_private_endpoint.this
  ]
}

# Waiting for the private endpoint to come online
resource "time_sleep" "this" {
  create_duration = "60s"

  depends_on = [
    azurerm_private_endpoint.this
  ]
}