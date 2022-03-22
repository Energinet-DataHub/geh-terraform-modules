# Azure Storage Account

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Storage Account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "storage_account_example" { 
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.1.0"

  name                      = "example-name"
  project_name              = "example-project-name"
  environment_short         = "p"
  environment_instance      = "001"
  resource_group_name       = "example-resource-group-name"
  location                  = "westeurope"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  containers                = [
    {
      name = "example-container-name-1",
    },
    {
      name = "example-container-name-2",
    },
  ]

  tags                      = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.9.0"
    "ModuleId"      = "azure-storage-account"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the Storage Account. | |
| `name` | The name of the Storage Account. | |
| `primary_blob_endpoint` | The endpoint URL for blob storage in the primary location. | |
| `primary_connection_string` | The connection string associated with the primary location. | `true` |
| `primary_access_key` | The primary access key for the storage account. | `true` |
