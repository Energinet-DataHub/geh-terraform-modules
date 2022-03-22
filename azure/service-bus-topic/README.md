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

See [variables.tf](./variables.tf)

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
