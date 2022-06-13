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
    "ModuleId"      = "azure-function-app"
  }
}

resource "azurerm_windows_function_app" "this" {
  name                        = "func-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  service_plan_id             = var.app_service_plan_id
  storage_account_name        = azurerm_storage_account.this.name
  storage_account_access_key  = azurerm_storage_account.this.primary_access_key
  functions_extension_version = "~4"
  builtin_logging_enabled     = false # Disabled to avoid having the setting "AzureWebJobsDashboard" when using Application Insights
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
    health_check_path = var.health_check_path
    application_stack {
      current_stack = "dotnet"
      dotnet_version = var.dotnet_framework_version
      use_dotnet_isolated_runtime  = true
    }
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
  app_service_id = azurerm_windows_function_app.this.id
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
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "pcs-01"
    private_connection_resource_id = azurerm_windows_function_app.this.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  tags                             = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
      private_dns_zone_group,
    ]
  }

  depends_on = [
    azurerm_windows_function_app.this
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
    "126.0.0.1"
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
      private_dns_zone_group,
    ]
  }

  depends_on = [
    azurerm_private_endpoint.file
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
      private_dns_zone_group,
    ]
  }
}

resource "azurerm_monitor_metric_alert" "health_check_alert" {
  count               = var.health_check_alert_action_group_id == null ? 0 : 1

  name                = "hca-${azurerm_windows_function_app.this.name}"
  resource_group_name = var.resource_group_name

  enabled             = var.health_check_alert_enabled
  severity            = 1
  scopes              = [azurerm_windows_function_app.this.id]
  description         = "Action will be triggered when health check fails."

  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace  = "Microsoft.Web/Sites"
    metric_name       = "HealthCheckStatus"
    operator          = "LessThan"
    aggregation       = "Average"
    threshold         = 100
  }

  action {
    action_group_id   = var.health_check_alert_action_group_id
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

resource "azurerm_monitor_diagnostic_setting" "func" {
  name                       = "diag-func-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  target_resource_id         = azurerm_windows_function_app.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_retention_in_days
    }
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      log,
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "stor" {
  name                       = "diag-stor-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  target_resource_id         = azurerm_storage_account.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_retention_in_days
    }
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      metric,
    ]
  }
}
