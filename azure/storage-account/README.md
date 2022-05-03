# Azure Storage Account

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Storage Account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
- [Azure Storage Account Network Rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules)
- [Azure Storage Account Container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "storage_account_example" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/storage-account?ref=6.0.0"

  name                            = "example-name"
  project_name                    = "example-project-name"
  environment_short               = "u"
  environment_instance            = "001"
  resource_group_name             = "example-resource-group-name"
  location                        = "westeurope"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_replication_type        = "LRS"

  containers                      = [
    {
      name = "example-container-name-1",
    },
    {
      name = "example-container-name-2",
    },
  ]

  tags                            = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-storage-account"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
