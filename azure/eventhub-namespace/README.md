# Azure Eventhub Namespace

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Eventhub Namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "eventhub_namespace_example" { 
  source                      = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/eventhub-namespace?ref=5.1.0"

  name                        = "example-name"
  project_name                = "example-project-name"
  environment_short           = "p"
  environment_instance        = "001"
  resource_group_name         = "example-resource-group-name"
  location                    = "westeurope"
  sku                         = "basic"
  log_analytics_workspace_id  = "example-log-analytics-workspace-id"
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.9.0"
    "ModuleId"      = "azure-eventhub-namespace"
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The Eventhub Namespace ID. |
| `name` | The Eventhub Namespace name. |