# Azure Microsoft SQL Database

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Microsoft SQL Database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_database)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.5+
- AzureRM provider version 2.94.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the Microsoft SQL Server. This needs to be globally unique within Azure. The final name of the resource will follow this syntax `sqldb-{var.name}-{var.project}-{var.organisation}-${var.environment}` and be in lowercase. |
| `project_name` | `string` | | **Required** | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the Function App. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `server_name` | `string` | | **Required** | The name of the SQL Server on which to create the database. |
| `log_analytics_workspace_id` | `string`| |**Required** | Name of associated Log Analytics Workspace. |
| `edition` | `string` | `Standard` | | The edition of the database to be created. Applies only if `create_mode` is Default. Valid values are: `Basic`, `Standard`, `Premium`, `DataWarehouse`, `Business`, `BusinessCritical`, `Free`, `GeneralPurpose`, `Hyperscale`, `Premium`, `PremiumRS`, `Standard`, `Stretch`, `System`, `System2`, or `Web`. Please see [Azure SQL Database Service Tiers](https://azure.microsoft.com/en-gb/documentation/articles/sql-database-service-tiers/). |
| `requested_service_objective_name` | `string` | `GP_S_Gen5_1` | | The service objective name for the database. Valid values depend on edition and location and may include `S0`, `S1`, `S2`, `S3`, `P1`, `P2`, `P4`, `P6`, `P11` and `ElasticPool`. You can list the available names with the cli: shell az sql db list-editions -l westus -o table. For further information please see [Azure CLI - az sql db](https://docs.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-list-editions). |
| `tags` | `string` | `{}` | | A mapping of tags to assign to the resource. |

## Usage

```ruby
module "sqldb_example" { 
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/sql-database?ref=5.1.0"

  name                        = "example-name"
  project_name                = "example-project-name"
  environment_short           = "p"
  environment_instance        = "001"
  resource_group_name         = "example-resource-group-name"
  location                    = "westeurope"
  server_name                 = "example-server-name"
  log_analytics_workspace_id  = "example-log-analytics-workspace-id"

  tags                = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.6.0"
    "ModuleId"      = "azure-sql-database"
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The SQL Database ID. |
| `name` | The SQL Database name. |
