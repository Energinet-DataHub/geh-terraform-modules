# Azure Service Bus Topic

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

**Notice**: [Partitioning is not support when using Premium Messaging](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-premium-messaging#partitioned-queues-and-topics)

- [Azure Service Bus Topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_bus_topic)
- [Azure Service Bus Subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_bus_subscription)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "service_bus_topic_example" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service_bus-topic?ref=6.0.0"
  name                = "example-name"
  namespace_id        = "/subscriptions/<subscription id>/resourceGroups/<resource group>/providers/Microsoft.ServiceBus/namespaces/example-namespace-name"

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

See [outputs.tf](./outputs.tf)
