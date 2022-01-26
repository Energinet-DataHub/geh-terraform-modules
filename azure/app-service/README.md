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

This module creates the following resources.

- [Azure App Service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service)
- [App Service Virtual Network Association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the App Service. Changing this forces a new resource to be created. The final name of the resource will follow this syntax `app-{var.name}-{var.project_name}-{var.environment_short}-${var.environment_instance}` and be lowercased. |
| `project_name` | `string` | | **Required** | | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** | |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the App Service. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `app_service_plan_id` | `string` | | **Required** | The ID of the App Service Plan within which to create this App Service. |
| `application_insights_instrumentation_key` | `string` | | **Required** | The application insights instrumentation key for which data is to be logged into. |
| `vnet_integration_subnet_id` | `string` | | **Required** | The id of the vnet integration subnet where this App Service will reside. |
| `app_settings` | `string` | `{}` | | A map of key-value pairs for App Settings and custom values. |
| `connection_strings` | `map(string)` | `{}` | | A map of key-value pairs for App Settings Connection Strings. |
| `linux_fx_version` | `string` | `DOTNETCORE|5.0` | | Use this when running on a Linux plan to specify .NET Core runtime version. |
| `dotnet_framework_version` | `string` | `v5.0` | | Use this when running on a Windows plan to specify .NET Core runtime version. |
| `always_on` | `bool` | `true` | | Should the App Service be loaded at all times? Defaults to false. |
| `tags` | `string` | `{}` | | A mapping of tags to assign to the resource. |

## Usage

```ruby
module "app_example" {
  source                                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/app-service?ref=6.0.0"

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
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-app-service"
  }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The ID of the App Service. |
| `name` | The name of the App Service. |
| `default_hostname` | The default hostname associated with the App Service - such as mysite.azurewebsites.net |
| `outbound_ip_addresses` | A comma separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12 |
| `possible_outbound_ip_addresses` | A comma separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12,52.143.43.17 - not all of which are necessarily in use. Superset of outbound_ip_addresses. |
| `identity` | An identity block as defined below, which contains the Managed Service Identity information for this App Service. |
| `site_credential` | A site_credential block as defined below, which contains the site-level credentials used to publish to this App Service. |
