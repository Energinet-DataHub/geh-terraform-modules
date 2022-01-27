# Azure Service Bus Queue

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

**Notice**: [Partitioning is not support when using Premium Messaging](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-premium-messaging#partitioned-queues-and-topics)

This module creates the following resources:

- [Azure Service Bus Queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_queue)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.91.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the Service Bus Queue resource. Changing this forces a new resource to be created. The final name will be lowercased. |
| `namespace_id` | `string` | | **Required** | The ID of the Service Bus Namespace to create this queue in. Changing this forces a new resource to be created. |
| `requires_session` | `false` | | | Boolean flag which controls whether the Queue requires sessions. This will allow ordered handling of unbounded sequences of related messages. With sessions enabled a queue can guarantee first-in-first-out delivery of messages. Changing this forces a new resource to be created. Defaults to false. |
| `requires_duplicate_detection` | `false` | | | Boolean flag which controls whether the Queue checks for duplicate messages within a time frame of 10 minutes (default). Changing this forces a new resource to be created. Defaults to false. |

## Usage

```ruby
module "service_bus_queue_example" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service_bus-queue?ref=6.0.0"
  name                = "example-name"
  namespace_id        = "/subscriptions/<subscription id>/resourceGroups/<resource group>/providers/Microsoft.ServiceBus/namespaces/example-namespace-name"
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The Service Bus Queue ID. |
| `name` | The Service Bus Queue ID. |
