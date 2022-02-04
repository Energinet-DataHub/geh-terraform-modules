# Azure Microsoft SQL Database

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resource:

- [Azure Microsoft MS SQL Database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "sqldb_example" {
  source                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/mssql-database?ref=6.0.0"

  name                          = "example-name"
  project_name                  = "example-project-name"
  environment_short             = "p"
  environment_instance          = "001"
  server_id                     = "some-mssql-server-id"
  sku_name                      = "GP_S_Gen5_2"

  tags                = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-mssql-database"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
