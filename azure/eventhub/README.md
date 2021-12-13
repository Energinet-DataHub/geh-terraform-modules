# Azure Eventhub

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub)
- [Azure EventHub authorization Rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the Eventhub resource. Changing this forces a new resource to be created. The final name will be lowercased. |
| `namespace_name` | `string` | | **Required** | The name of the Eventhub Namespace to create this Eventhub in. Changing this forces a new resource to be created. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which the Eventhub's parent Namespace exists. Changing this forces a new resource to be created. |
| `partition_count` | `number` | | **Required** | Specifies the current number of shards on the Eventhub. |
| `message_retention` | `number` | | **Required** | Specifies the number of days to retain the messages for this Eventhub. |
| `auth_rules` | `list` | `[]` | | **Required** | A list of objects describing the auth rules of the Eventhub. See [Auth Rule](#auth-rule). |

### Auth Rule

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the ServiceBus Namespace Authorization Rule resource. Changing this forces a new resource to be created. The final name of the resource will be in lowercase. |
| `listen` | `bool` | `false` | | Grants listen access to this this Authorization Rule. Defaults to `false`. |
| `send` | `list(string)` | `false` | | Grants send access to this this Authorization Rule. Defaults to `false`. |
| `manage` | `list(string)` | `false` | | Grants manage access to this this Authorization Rule. When this property is `true` - both `listen` and `send` must be too. Defaults to `false`. |

## Usage

```ruby
module "eventhub_example" { 
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/eventhub?ref=5.1.0"
  name                = "example-name"
  namespace_name      = "example-namespace-name"
  resource_group_name = "example-resource-group-name"
  partition_count     = 2
  message_retention   = 1
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

## Outputs

| Name | Description |
|-|-|
| `id` | The Eventhub ID. |
| `name` | The name of the EventHub. |
| `primary_connection_strings` | A list of Auth Rule connection strings |
