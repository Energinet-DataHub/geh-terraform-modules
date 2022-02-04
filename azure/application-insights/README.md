# Application Insights

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Application Insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "appi_example" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/application-insights?ref=6.0.0"

  name                  = "example-name"
  project_name          = "example-project-name"
  environment_short     = "p"
  environment_instance  = "001"
  resource_group_name   = "example-resource-group-name"
  location              = "westeurope"

  tags                  = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-application-insights"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
