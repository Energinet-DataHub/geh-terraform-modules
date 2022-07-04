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

- Terraform version 1.2.2+
- AzureRM provider version 3.9.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "appi_example" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/application-insights?ref=7.0.0"

  name                  = "example-name"
  project_name          = "example-project-name"
  environment_short     = "u"
  environment_instance  = "001"
  resource_group_name   = "example-resource-group-name"
  location              = "westeurope"
  log_analytics_workspace_id  = "example-log-workspace-id"

  tags                  = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleId"      = "azure-application-insights"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
