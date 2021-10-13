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
    azurerm_monitor_metric_alert.main
  ]
}

###
### 1 - Function App Storage Account
###
resource "azurerm_storage_account" "main" {
  depends_on                        = [null_resource.dependency_getter]
  name                              = "st${random_string.datamigrator.result}"
  resource_group_name               = var.resource_group_name 
  location                          = var.location 
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  min_tls_version                   = "TLS1_2"
  tags                              = var.tags
}

resource "random_string" "datamigrator" {
  length  = 10
  special = false
  upper   = false
}

###
### 2 - Function App
###
resource "azurerm_function_app" "main" {
  depends_on                  = [azurerm_storage_account.main]
  name                        = "func-${lower(var.name)}-${lower(var.project_name)}-${lower(var.organisation_name)}-${lower(var.environment_short)}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  app_service_plan_id         = var.app_service_plan_id
  storage_account_name        = azurerm_storage_account.main.name
  storage_account_access_key  = azurerm_storage_account.main.primary_access_key
  version                     = "~3"
  tags                        = var.tags
  https_only                  = true
  app_settings                = merge({
    APPINSIGHTS_INSTRUMENTATIONKEY = var.application_insights_instrumentation_key
  },var.function_app_settings)

  dynamic "connection_string" {
    for_each = var.function_connection_string
    content {
      name    = connection_string.key
      value   = connection_string.value
      type    = "Custom"
    }
  }
  
  identity {
    type = "SystemAssigned"
  }
  
  site_config {
    always_on                   = var.function_always_on
    cors {
      allowed_origins = ["*"]
    }
  }

  lifecycle {
    ignore_changes = [
      source_control
    ]
  }
}

###
### 3 - Function App Web Test
###
locals {
  web_test_name = "at-${lower(var.name)}-${lower(var.project_name)}-${lower(var.organisation_name)}-${lower(var.environment_short)}"
}

resource "azurerm_application_insights_web_test" "main" {
  depends_on              = [azurerm_function_app.main]
  name                    = local.web_test_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  tags                    = var.tags
  application_insights_id = var.application_insights_id
  kind                    = "ping"
  frequency               = var.web_test_frequency
  timeout                 = var.web_test_timeout
  enabled                 = var.web_test_enabled
  retry_enabled           = var.web_test_retry_enabled
  geo_locations           = var.web_test_geo_locations

  configuration = <<XML
<WebTest Name="${local.web_test_name}" Id="ABD48585-0831-40CB-9069-682EA6BB3583" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="0" WorkItemIds="" xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale="">
  <Items>
    <Request Method="GET" Guid="a5f10126-e4cd-570d-961c-cea43999a200" Version="1.1" Url="https://${azurerm_function_app.main.default_hostname}/api/health/HealthStatus" ThinkTime="0" Timeout="300" ParseDependentRequests="False" FollowRedirects="False" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" />
  </Items>
</WebTest>
XML
}

###
### 4 - Function App Metric Alert
###
resource "azurerm_monitor_metric_alert" "main" {
  depends_on              = [azurerm_application_insights_web_test.main]
  name                    = "ma-${lower(var.name)}-${lower(var.project_name)}-${lower(var.organisation_name)}-${lower(var.environment_short)}"
  resource_group_name     = var.resource_group_name 
  scopes                  = [
    var.application_insights_id
  ]
  description             = var.metric_alert_description
  
  criteria {
    metric_namespace      = "Microsoft.Insights/components"
    metric_name           = "availabilityResults/count"
    aggregation           = "Count"
    operator              = "GreaterThan"
    threshold             = var.metric_alert_threshold
    dimension {
      name                = "availabilityResult/name"
      operator            = "Include"
    values                = [
      azurerm_application_insights_web_test.main.name,
    ]
  }
	dimension {
      name                = "availabilityResult/success"
      operator            = "Include"
      values              = [
        "0"
      ]
    }
  }
  action {
    action_group_id       = var.metric_alert_action_group_id
  }
  frequency               = var.metric_alert_frequency
  window_size             = var.metric_alert_window_size
  tags                    = var.tags
}