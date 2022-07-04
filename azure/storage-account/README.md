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
- [Azure Private Endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
- [Azure Storage Account Container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container)
- [Azure Storage Account File Share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.2.2+
- AzureRM provider version 3.9.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "storage_account_example" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/storage-account?ref=7.0.0"

  name                            = "example-name"
  project_name                    = "example-project-name"
  environment_short               = "u"
  environment_instance            = "001"
  resource_group_name             = "example-resource-group-name"
  location                        = "westeurope"
  private_endpoint_subnet_id      = "example-private-endpoint-subnet-id"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  log_analytics_workspace_id      = "example-log-analytics-workspace"

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
    "ModuleId"      = "azure-storage-account"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
