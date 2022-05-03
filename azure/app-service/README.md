# Azure App Service

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Module basis

This module is based on the knowledge derived from these resources

- [Integrate your app with an Azure virtual network](https://docs.microsoft.com/en-us/azure/app-service/overview-vnet-integration)

## Resources Created

This module creates the following resources:

- [Azure App Service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service)
- [App Service Virtual Network Association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection)
- [Azure Monitor Metric Alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_metric_alert)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "app_example" {
  source                                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/app-service?ref=6.0.0"

  name                                      = "example-name"
  project_name                              = "example-project-name"
  environment_short                         = "u"
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
    "ModuleId"      = "azure-app-service"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
