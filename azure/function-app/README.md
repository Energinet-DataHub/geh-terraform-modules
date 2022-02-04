# Azure Function App

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Module basis

This module is based on the knowledge derived from these resources

- [How to configure Azure Functions with a virtual network](https://docs.microsoft.com/en-us/azure/azure-functions/configure-networking-how-to#restrict-your-storage-account-to-a-virtual-network)
- [Private Endpoints with Terraform](https://jfarrell.net/2021/07/03/private-endpoints-with-terraform/)

## Resources Created

This module creates the following resources:

- [Azure Function App](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "func_example" {
  source                                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/function-app?ref=6.0.0"

  name                                      = "example-name"
  project_name                              = "example-project-name"
  environment_short                         = "p"
  environment_instance                      = "001"
  resource_group_name                       = "example-resource-group-name"
  location                                  = "westeurope"
  app_service_plan_id                       = "id-example"
  application_insights_instrumentation_key  = "app-insights-instrumentation-key-example"
  vnet_integration_subnet_id                = "vnet-integration-subnet-id"
  app_settings                              = {
    "example-key1" = "example-value1"
    "example-key2" = "example-value2"
  }
  connection_strings                        = [
    {
      name  = "example-name"
      type  = "SQLAzure"
      value = "example-value"
    }
  ]

  tags                                      = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-function-app"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
