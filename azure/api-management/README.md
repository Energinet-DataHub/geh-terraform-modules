# Azure Api Management

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Api Management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "appi_example" { 
  source                     = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management?ref=5.7.0"

  name                       = "example-name"
  project_name               = "example-project-name"
  environment_short          = "p"
  environment_instance       = "001"
  resource_group_name        = "example-resource-group-name"
  location                   = "westeurope"
  publisher_name             = "John Doe"
  publisher_email            = "johndoe@example.com"
  sku_name                   = "Developer_1"
  log_analytics_workspace_id = "example-log-analytics-workspace-id"
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.7.0"
    "ModuleId"      = "azure-api-management"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the API Management Service. | |
| `name` | The name of the API Management Service. | |
