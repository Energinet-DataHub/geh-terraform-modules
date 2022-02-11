# Azure Log Workspace

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resource:

- [Azure Log Workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)


## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)




## Usage

```ruby
module "log_workspace_example" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/log-workspace?ref=feature/log-workspace"

  name                            = "example-name"
  project_name                    = "example-project-name"
  environment_short               = "u"
  environment_instance            = "001"
  resource_group_name             = "example-resource-group-name"
  location                        = "westeurope"
  sku_name                        = "standard"
  private_endpoint_subnet_id      = "private-endpoint-subnet-id"
  private_dns_resource_group_name = "private-dns-resource-group-name"
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "?.?.?"
    "ModuleId"      = "azure-log-workspace"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
