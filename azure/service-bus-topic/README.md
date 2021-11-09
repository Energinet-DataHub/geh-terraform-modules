# Azure Service Bus Topic

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Service Bus Topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_bus_topic)
- [Azure Service Bus Subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_bus_subscription)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the Service Bus Topic resource. Changing this forces a new resource to be created. The final name will be lowercased. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the topic. Changing this forces a new resource to be created. |
| `namespace_name` | `string` | | **Required** | The name of the Service Bus Namespace to create this topic in. Changing this forces a new resource to be created. |
| `requires_session` | `false` | | | Boolean flag which controls whether the Queue requires sessions. This will allow ordered handling of unbounded sequences of related messages. With sessions enabled a queue can guarantee first-in-first-out delivery of messages. Changing this forces a new resource to be created. Defaults to false. |
| `subscriptions` | `list` | `[]` | | A list of objects describing the subscriptions of the Service Bus Topic. See [Subscription](#subscription). |

### Subscription

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the ServiceBus Subscription resource. Changing this forces a new resource to be created. The final name will be lowercased. |
| `forward_to` | `string` | | | The name of a Queue or Topic to automatically forward messages to. |
| `max_delivery_count` | `string` | `1` | | The maximum number of deliveries. |

## Usage

```ruby
module "service_bus_topic_example" { 
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service_bus-topic?ref=5.1.0"
  name                = "example-name"
  namespace_name      = "example-namespace-name"
  subscriptions       = [
    {
      name                = "example-subscription-1"
      forward_to          = "example-queue-or-topic"
    },
    {
      name                = "example-subscription-2"
      forward_to          = "example-queue-or-topic"
    },
  ]
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The Service Bus Topic ID. |
| `name` | The Service Bus Topic ID. |
