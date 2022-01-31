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
    "ModuleId"      = "azure-app-service"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  app_service_id = azurerm_app_service.this.id
  subnet_id      = var.vnet_integration_subnet_id
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
      name = each.value.name
      type = each.value.type
      value = each.value.value
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