# Azure Service Bus Namespace

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Service Bus Namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_bus_namespace)
- [Azure Service Bus Namespace Authorization Rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the Microsoft SQL Server. This needs to be globally unique within Azure. The final name of the resource will follow this syntax `sb-{var.name}-${var.environment_short}-${var.environment_instance}` and be in lowercase. |
| `project_name` | `string` | | **Required** | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the Function App. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `sku` | `string` | | **Required** | Defines which tier to use. Options are `basic`, `standard` or `premium`. Changing this forces a new resource to be created. |
| `auth_rules` | `list` | | **Required** | A list of objects describing the auth rules of the Service Bus Namespace. See [Auth Rule](#auth-rule). |
| `private_endpoint_subnet_id` | `string` | | **Required**  | The ID of the private endpoint subnet
| `private_dns_resource_group_name` | `string` | | **Required**  | Specifies the resource group where the Private DNS Zone exists. Changing this forces a new resource to be created.
| `tags` | `string` | `{}` | | A mapping of tags to assign to the resource. |

### Auth Rule

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the ServiceBus Namespace Authorization Rule resource. Changing this forces a new resource to be created. The final name of the resource will be in lowercase. |
| `listen` | `bool` | `false` | | Grants listen access to this this Authorization Rule. Defaults to `false`. |
| `send` | `list(string)` | `false` | | Grants send access to this this Authorization Rule. Defaults to `false`. |
| `manage` | `list(string)` | `false` | | Grants manage access to this this Authorization Rule. When this property is `true` - both `listen` and `send` must be too. Defaults to `false`. |

## Usage

```ruby
module "service_bus_namespace_example" { 
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service_bus-namespace?ref=5.1.0"

  name                  = "example-name"
  project_name          = "example-project-name"
  environment_short     = "p"
  environment_instance  = "001"
  resource_group_name   = "example-resource-group-name"
  location              = "westeurope"
  sku                   = "basic"
  auth_rules            = [
    {
      name    = "example-auth-rule-1"
      listen  = true
    },
    {
      name    = "example-auth-rule-2"
      listen  = true
      send    = true
      manage  = true
    }
  ]
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.1.0"
    "ModuleId"      = "azure-service-bus-namespace"
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The ServiceBus Namespace ID. |
| `name` | The ServiceBus Namespace name. |
| `primary_connection_strings` | A list of Auth Rule connection strings, can be accessed this way `var.primary_connection_strings["example-auth-rule-1"]` |
