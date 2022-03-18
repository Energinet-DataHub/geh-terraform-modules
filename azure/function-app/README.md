# Azure Function App

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Function App](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app)
- [Azure Monitor Metric Alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "func_example" {
  source                                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/function-app?ref=5.8.0"

  name                                      = "example-name"
  project_name                              = "example-project-name"
  environment_short                         = "p"
  environment_instance                      = "001"
  resource_group_name                       = "example-resource-group-name"
  location                                  = "westeurope"
  app_service_plan_id                       = "id-example"
  application_insights_instrumentation_key  = "app-insights-instrumentation-key-example"
  app_settings                              = {
    "example-key1" = "example-value1"
    "example-key2" = "example-value2"
  }
  connection_strings                        = {
    "example-key1" = "example-value1"
    "example-key1" = "example-value1"
  }

  tags                                      = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.8.0"
    "ModuleId"      = "azure-function-app"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
