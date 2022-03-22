# Azure Microsoft SQL Server

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Microsoft SQL Server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_server)
- [Azure Private Endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
- [Azure Private DNS A Record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record)
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
  source                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/mssql-server?ref=6.0.0"

  name                            = "example-name"
  project_name                    = "example-project-name"
  environment_short               = "u"
  environment_instance            = "001"
  resource_group_name             = "example-resource-group-name"
  location                        = "westeurope"
  sql_version                     = "12.0"
  administrator_login             = "example-administrator-login"
  administrator_login_password    = "example-administrator-login-password"
  private_endpoint_subnet_id      = "private-endpoint-subnet-id"
  private_dns_resource_group_name = "private-dns-resource-group-name"
  log_analytics_workspace_id      = "example-log-analytics-workspace-id"

  tags                          = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-mssql-server"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
