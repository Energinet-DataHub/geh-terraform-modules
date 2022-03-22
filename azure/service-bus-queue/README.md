# Azure Service Bus Queue

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Service Bus Queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_bus_queue)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

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
