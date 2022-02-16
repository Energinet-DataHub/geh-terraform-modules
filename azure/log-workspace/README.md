# Azure Log Workspace

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resource:

- [Azure Log Workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/)


## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)




## Usage

```ruby
module "log_workspace_example" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/log-workspace?ref=5.6.0"

  name                  = "example-name"
  project_name          = "example-project"
  environment_short     = "u"
  environment_instance  = "001"
  resource_group_name   = "example-log-workspace-name"
  location              = "westeurope"
  sku                   = "Br4711"
  retention_in_days     = 60
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.6.0"
    "ModuleId"      = "azure-log-workspace"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
