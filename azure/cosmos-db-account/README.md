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

See [variables.tf](./variables.tf)

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

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-cosmos-db-account"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
