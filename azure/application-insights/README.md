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

- Terraform version 1.1.5+
- AzureRM provider version 2.94.0+

## Arguments and defaults

See [variables.tf](./variables.tf)


## Usage

```ruby
module "appi_example" { 
  source                      = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/application-insights?ref=5.6.0"

  name                        = "example-name"
  project_name                = "example-project-name"
  environment_short           = "p"
  environment_instance        = "001"
  resource_group_name         = "example-resource-group-name"
  location                    = "westeurope"
  log_analytics_workspace_id  = "example-log-workspace-id"
  tags                        = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.6.0" 
    "ModuleId"      = "azure-application-insights"  
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
