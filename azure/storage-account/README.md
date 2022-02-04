# Azure Storage Account

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Storage Account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

### Container

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the Container which should be created within the Storage Account. The final name of the resource will be in lowercase. |
| `access_type` | `string` | `private` | | The Access Level configured for this Container. Possible values are `blob`, `container` or `private`. Defaults to `private`. |

## Usage

```ruby
module "storage_account_example" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/storage-account?ref=6.0.0"

  name                            = "example-name"
  project_name                    = "example-project-name"
  environment_short               = "p"
  environment_instance            = "001"
  resource_group_name             = "example-resource-group-name"
  private_dns_resource_group_name = "example-private-dns-resource-group-name"
  private_endpoint_subnet_id      = "example-private-endpoint-subnet-id"
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
