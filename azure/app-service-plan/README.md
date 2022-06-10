# App Service Plan

- [Purpose](#purpose)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure App Service Plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan)
- [Azure Monitor Metric Alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "plan_example" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/app-service-plan?ref=6.0.0"

  name                            = "example-name"
  project_name                    = "example-project-name"
  environment_short               = "u"
  environment_instance            = "001"
  resource_group_name             = "example-resource-group-name"
  location                        = "westeurope"
  monitor_alerts_action_group_id  = "example-action-group-id"
  sku                             = {
    tier = "Free"
    size = "F1"
  }

  tags                           = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleId"      = "azure-app-service-plan"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
