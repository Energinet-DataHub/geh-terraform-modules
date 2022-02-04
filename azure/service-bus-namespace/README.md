# Azure Service Bus Namespace

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

**Notice:** This module always creates a Service Bus with SKU = Premium (to support VNet).

This module creates the following resources:

- [Azure Service Bus Namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace)
- [Azure Service Bus Namespace Authorization Rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule)
- [Azure Service Bus Namespace Network Rule Set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_network_rule_set)
- [Azure Private Endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
- [Azure Private DNS A Record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

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
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service_bus-namespace?ref=6.0.0"

  name                            = "example-name"
  project_name                    = "example-project-name"
  environment_short               = "u"
  environment_instance            = "001"
  resource_group_name             = "example-resource-group-name"
  location                        = "westeurope"
  private_endpoint_subnet_id      = "private-endpoint-subnet-id"
  private_dns_resource_group_name = "private-dns-resource-group-name"

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

  tags                          = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-service-bus-namespace"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
