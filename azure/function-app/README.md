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

This module creates the following resources.

- [Azure Function App](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.71.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the Function App. Changing this forces a new resource to be created. The final name of the resource will follow this syntax `func-{var.name}-{var.project}-{var.organisation}-${var.environment}` and be lowercased. |
| `project_name` | `string` | | **Required** | | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** | |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the Function App. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `app_service_plan_id` | `string` | | **Required** | The ID of the App Service Plan within which to create this Function App. |
| `application_insights_instrumentation_key` | `string` | | **Required** | The application insights instrumentation key for which data is to be logged into. |
| `vnet_integration_subnet_id` | `string` | | **Required** | The id of the vnet integration subnet where this function will reside. |
| `app_settings` | `string` | `{}` | | The application insights instrumentation id for which data is to be logged into. |
| `connection_strings` | `map(string)` | `{}` | | A map of key-value pairs for App Settings and custom values. |
| `always_on` | `map(string)` | `{}` | | Should the Function App be loaded at all times? Defaults to false. |
| `tags` | `string` | `{}` | | A mapping of tags to assign to the resource. |

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
  connection_strings                        = {
    "example-key1" = "example-value1"
    "example-key1" = "example-value1"
  }

  tags                                      = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.1.0"   
    "ModuleId"      = "azure-function-app"
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The ID of the Function App. |
| `name` | The name of the Function App. |
| `default_hostname` | The default hostname associated with the Function App - such as mysite.azurewebsites.net |
| `outbound_ip_addresses` | A comma separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12 |
| `possible_outbound_ip_addresses` | A comma separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12,52.143.43.17 - not all of which are necessarily in use. Superset of outbound_ip_addresses. |
| `identity` | An identity block as defined below, which contains the Managed Service Identity information for this App Service. |
| `site_credential` | A site_credential block as defined below, which contains the site-level credentials used to publish to this App Service. |
| `kind` | The Function App kind - such as functionapp,linux,container |
