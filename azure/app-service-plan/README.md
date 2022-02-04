# App Service Plan

- [Purpose](#purpose)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure App Service Plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

### Sku

A `sku` item consists of the following:

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `tier` | `string` | | **Required** | Specifies the plan's pricing tier. |
| `size` | `string` | | **Required** | Specifies the plan's instance size. |

## Usage

```ruby
module "plan_example" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/app-service-plan?ref=6.0.0"

  name                  = "example-name"
  project_name          = "example-project-name"
  environment_short     = "p"
  environment_instance  = "001"
  resource_group_name   = "example-resource-group-name"
  location              = "westeurope"
  sku                   = {
    tier = "Free"
    size = "F1"
  }

  tags                  = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0",
    "ModuleId"      = "azure-app-service-plan"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
