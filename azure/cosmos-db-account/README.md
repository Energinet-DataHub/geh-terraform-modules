# Azure Cosmos DB

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Cosmos DB Account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the Cosmos DB Account. This needs to be globally unique within Azure. The final name of the resource will follow this syntax `cosmos-{var.name}--${var.project_name}-${var.environment_short}-${var.environment_instance}` and be in lowercase. |
| `project_name` | `string` | | **Required** | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** | The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the Cosmos DB Account. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `private_endpoint_subnet_id` | `string` | | **Required**  | The id of the private endpoint subnet where this resource will reside |
| `private_dns_resource_group_name` | `string` | | **Required**  | Specifies the resource group where the Private DNS Zone exists. Changing this forces a new resource to be created. |
| `tags` | `string` | `{}` | | A mapping of tags to assign to the resource. |

## Usage

```ruby
module "cosmos_db_example" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/cosmos-db-account?ref=6.0.0"

  name                            = "example-name"
  project_name                    = "example-project-name"
  environment_short               = "u"
  environment_instance            = "001"
  resource_group_name             = "example-resource-group-name"
  location                        = "westeurope"
  private_endpoint_subnet_id      = "private-endpoint-subnet-id"
  private_dns_resource_group_name = "private-dns-resource-group-name"

  tags                            = {}
}
```

Two tags are added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-cosmos-db-account"
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The Cosmos DB Account ID. |
| `name` | The Cosmos DB Account name. |
| `endpoint` | The Cosmos DB Account endpoint. |
| `primary_key` | The Cosmos DB Account primary key. |
