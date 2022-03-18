# Azure Microsoft SQL Database

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resource:

- [Azure Microsoft MS SQL Database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the Microsoft SQL Server. This needs to be globally unique within Azure. The final name of the resource will follow this syntax `mssqldb-{name}-{project_name}-{environment_short}-{environment_instance}` and be in lowercase. |
| `project_name` | `string` | | **Required** | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** |  The instance number of your environment. |
| `server_id` | `string` | | **Required** | The ID of the SQL Server on which to create the database. |
| `log_analytics_workspace_id` | `string`| |**Required** | Name of associated Log Analytics Workspace. |
| `sku_name` | `string` | `GP_S_Gen5_1` | | The SKU of the database to be created. |
| `min_capacity` | `number` | `1` | | Minimal capacity of vCores that database will always have allocated, if not paused. |
| `auto_pause_delay_in_minutes` | `number`| `-1` | | Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases. |
| `tags` | `string` | `{}` | | A mapping of tags to assign to the resource. |

## Usage

```ruby
module "sqldb_example" { 
  source                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/sql-database?ref=5.7.0"

  name                          = "example-name"
  project_name                  = "example-project-name"
  environment_short             = "p"
  environment_instance          = "001"
  server_id                     = "some-mssql-server-id"
  sku_name                      = "GP_S_Gen5_2"
  log_analytics_workspace_id    = "example-log-analytics-workspace-id"

  tags                = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.7.0"
    "ModuleId"      = "azure-mssql-database"
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The SQL Database ID. |
| `name` | The SQL Database name. |
