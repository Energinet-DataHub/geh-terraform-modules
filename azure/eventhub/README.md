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

See [variables.tf](./variables.tf)

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
