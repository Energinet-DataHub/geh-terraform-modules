# Application Insights

- [Purpose](#purpose)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Purpose

This repository contains a terraform module that creates an Api Management resource inside the specified resource group.

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+
- Azure Resource Group
- Azure Application Service Plan
- Azure Application Insights

## Arguments and defaults

| Name | Type | Default | Description |
|-|-|-|-|
| `name` | `string` | | **Required** Specifies the name of the Function App. Changing this forces a new resource to be created. The final name of the resource will follow this syntax `appi-{var.name}-{var.project}-{var.organisation}-${var.environment}` and be in lowercase. |
| `organisation_name` | `string` | | **Required** (Required) The name of your organisation. |
| `project_name` | `string` | | **Required** (Required) The name of your project. |
| `environment_short` | `string` | | **Required** (Required) The short value name of your environment. |
| `resource_group_name` | `string` | | **Required** (Required) The name of the resource group in which to create the Function App. |
| `location` | `string` | | **Required** Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `tags` | `string` | `{}` | (Optional) A mapping of tags to assign to the resource. |
| `dependencies` | `string` | `[]` | (Optional) A mapping of dependencies which this module depends on. |

## Usage

```ruby
module "application_insights_example" { 
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/application-insights?ref=3.1.0"
  name                = "example-name"
  organisation_name   = "example-organisation"
  project_name        = "example-project"
  resource_group_name = "example-resource-group-name"
  location            = "westeurope"

  tags                = {}

  dependencies        = [
    module.example.dependent_on,
  ]
}
```

Two tags is added by default

```ruby
locals {
   module_tags = {
        "ModuleVersion" = "3.1.0"   
    }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The ID of the Function App. |
| `name` | The name of the Function App. |
| `dependent_on` | The dependencies of the Function App. |
| `instrumentation_key` | The Instrumentation Key for this Application Insights component. |
