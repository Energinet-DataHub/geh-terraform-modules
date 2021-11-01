# Azure Service Bus Queue

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Service Bus Queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_bus_queue)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the Service Bus Queue resource. Changing this forces a new resource to be created. The final name of the resource will follow this syntax `sbq-{var.name}` and be in lowercase. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the queue. Changing this forces a new resource to be created. |
| `namespace_name` | `string` | | **Required** | The name of the Service Bus Namespace to create this queue in. Changing this forces a new resource to be created. |
| `requires_session` | `false` | | | Boolean flag which controls whether the Queue requires sessions. This will allow ordered handling of unbounded sequences of related messages. With sessions enabled a queue can guarantee first-in-first-out delivery of messages. Changing this forces a new resource to be created. Defaults to false. |

## Usage

```ruby
module "service_bus_queue_example" { 
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service_bus-queue?ref=5.1.0"
  name                = "example-name"
  namespace_name      = "example-namespace-name"
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The Service Bus Queue ID. |
| `name` | The Service Bus Queue ID. |
