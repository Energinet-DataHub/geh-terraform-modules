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
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "service_bus_namespace_example" { 
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service_bus-namespace?ref=5.7.0"

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
    "ModuleVersion" = "5.7.0"
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
