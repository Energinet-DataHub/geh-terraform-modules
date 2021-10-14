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
    azurerm_function_app.this
  ]
}

locals {
  module_tags = {
    "ModuleVersion" = "3.1.0"
  }
}

resource "azurerm_storage_account" "this" {
  name                      = "st${random_string.this.result}"
  resource_group_name       = var.resource_group_name 
  location                  = var.location 
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  min_tls_version           = "TLS1_2"

  tags                      = merge(var.tags,local.module_tags)

  depends_on                = [
    null_resource.dependency_getter,
  ]

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "random_string" "this" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_function_app" "this" {
  name                        = "func-${lower(var.name)}-${lower(var.project_name)}-${lower(var.organisation_name)}-${lower(var.environment_short)}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  app_service_plan_id         = var.app_service_plan_id
  storage_account_name        = azurerm_storage_account.this.name
  storage_account_access_key  = azurerm_storage_account.this.primary_access_key
  version                     = "~3"
  https_only                  = true
  app_settings                = merge({
    APPINSIGHTS_INSTRUMENTATIONKEY = var.application_insights_instrumentation_key
  },var.function_app_settings)
  identity {
    type = "SystemAssigned"
  }
  site_config {
    always_on = var.function_always_on
    cors {
      allowed_origins = ["*"]
    }
  }
  dynamic "connection_string" {
    for_each  = var.function_connection_string
    content {
      name  = connection_string.key
      value = connection_string.value
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
