# App Service Plan

- [Purpose](#purpose)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure App Service Plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the App Service Plan component. Changing this forces a new resource to be created. The final name of the resource will follow this syntax `plan-{var.name}-{var.project_name}-${var.environment_short}-${var.environment_instance}` and be in lowercase. |
| `project_name` | `string` | | **Required** | | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** | |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the App Service Plan component. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `kind` | `string` | `Windows` | **Required** | The kind of the App Service Plan to create. Possible values are `Windows` (also available as `App`), `Linux`, `elastic` (for Premium Consumption) and `FunctionApp` (for a Consumption Plan). Defaults to `Windows`. Changing this forces a new resource to be created. |
| `reserved` | `boolean` | `false` | | Is this App Service Plan Reserved. Defaults to false. |
| `capacity` | `number` | `1` | | (Optional) Specifies the number of workers associated with this App Service Plan. |
| `sku` | `string` | | **Required** | An object describing the sku for the App Service Plan. See [Sku](#sku). |
| `tags` | `string` | `{}` | | A mapping of tags to assign to the resource. |

### Sku

A `sku` item consists of the following:

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `tier` | `string` | | **Required** | Specifies the plan's pricing tier. |
| `size` | `string` | | **Required** | Specifies the plan's instance size. |

## Usage

```ruby
module "plan_example" { 
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/app-service-plan?ref=5.1.0"

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

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.1.0",
    "ModuleId"      = "azure-app-service-plan"
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The ID of the Function App. |
| `name` | The name of the Function App. |
| `instrumentation_key` | The Instrumentation Key for this Application Insights component. |
