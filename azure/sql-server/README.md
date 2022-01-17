# Azure Microsoft SQL Server

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Microsoft SQL Server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_server)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the Microsoft SQL Server. This needs to be globally unique within Azure. The final name of the resource will follow this syntax `sql-{var.name}-${var.environment_short}` and be in lowercase. |
| `project_name` | `string` | | **Required** | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the Function App. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `sql_version` | `string` | | **Required** | The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server). |
| `administrator_login` | `string` | | **Required** | The administrator login name for the new server. Changing this forces a new resource to be created. |
| `administrator_login_password` | `string` | | **Required** | The password associated with the administrator_login user. Needs to comply with Azure's [Password Policy](https://msdn.microsoft.com/library/ms161959.aspx) |
| `private_endpoint_subnet_id` | `string` | | **Required**  The ID of the private endpoint subnet
| `private_dns_zone_name` | `string` | | **Required**  The name of the private dns zone
private_dns_zone_name
| `firewall_rules` | `any` | `[]` | | A list of objects describing the firewall rules of the Microsoft SQL Server. See [Firewall Rule](#firewall-rule). |
| `tags` | `string` | `{}` | | A mapping of tags to assign to the resource. |

### Firewall Rule

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| name | `string` | | **Required** | The name of the firewall rule. |
| start_ip_address | `string` | | **Required** | The starting IP address to allow through the firewall for this rule. |
| end_ip_address | `string` | | **Required** | The ending IP address to allow through the firewall for this rule. |

## Usage

```ruby
module "sql_server_example" { 
  source                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/sql-server?ref=5.1.0"

  name                          = "example-name"
  project_name                  = "example-project-name"
  environment_short             = "p"
  environment_instance          = "001"
  resource_group_name           = "example-resource-group-name"
  location                      = "westeurope"
  sql_version                   = "12.0"
  administrator_login           = "example-administrator-login"
  administrator_login_password  = "example-administrator-login-password"
  firewall_rules = [
    {
      name              = "example-rule-name"
      start_ip_address  = "0.0.0.0"
      end_ip_address    = "255.255.255.255"
    }
  ]

  tags                          = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.1.0"
    "ModuleId"      = "azure-sql-server"
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The ID of the Function App. |
| `name` | The name of the Function App. |
| `fully_qualified_domain_name` | The fully qualified domain name of the Azure SQL Server (e.g. myServerName.database.windows.net) |
| `identity_principal_id` | The Principal ID for the Service Principal associated with the Identity of this SQL Server. |
| `identity_tenant_id` | The Tenant ID for the Service Principal associated with the Identity of this SQL Server. |
