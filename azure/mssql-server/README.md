# Azure Microsoft SQL Server

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Microsoft SQL Server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_server)
- [Azure Microsoft SQL firewall rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "sql_server_example" { 
  source                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/sql-server?ref=5.4.0"

  name                          = "example-name"
  project_name                  = "example-project-name"
  environment_short             = "p"
  environment_instance          = "001"
  resource_group_name           = "example-resource-group-name"
  location                      = "westeurope"
  sql_version                   = "12.0"
  administrator_login           = "example-administrator-login"
  administrator_login_password  = "example-administrator-login-password"
  log_analytics_workspace_id    = "example-log-analytics-workspace-id"

  tags                          = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.7.0"
    "ModuleId"      = "azure-mssql-server"
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The ID of the MS SQL Server. |
| `name` | The name of the MS SQL Server. |
| `fully_qualified_domain_name` | The fully qualified domain name of the Azure SQL Server (e.g. myServerName.database.windows.net) |
| `identity_principal_id` | The Principal ID for the Service Principal associated with the Identity of this MS SQL Server. |
| `identity_tenant_id` | The Tenant ID for the Service Principal associated with the Identity of this MS SQL Server. |
