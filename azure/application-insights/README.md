# Application Insights

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Application Insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the Function App. Changing this forces a new resource to be created. The final name of the resource will follow this syntax `appi-{var.name}-{var.project_name}-${var.environment_short}-${var.environment_instance}` and be in lowercase. |
| `project_name` | `string` | | **Required** | | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** | |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | (Required) The name of the resource group in which to create the Function App. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `retention_in_days` | `string` | | **Required** | How long are logs retained. |
| `tags` | `string` | `{}` | | A mapping of tags to assign to the resource. |

## Usage

```ruby
module "appi_example" { 
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/application-insights?ref=5.0.0"

  name                  = "example-name"
  project_name          = "example-project-name"
  environment_short     = "p"
  environment_instance  = "001"
  resource_group_name   = "example-resource-group-name"
  location              = "westeurope"

  tags                  = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.1.0" 
    "ModuleId"      = "azure-application-insights"  
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The ID of the Function App. |
| `name` | The name of the Function App. |
| `instrumentation_key` | The Instrumentation Key for this Application Insights component. |
