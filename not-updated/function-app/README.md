# Azure Function App Module

- [Purpose](#purpose)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Purpose

This repository contains a terraform module that creates a Azure Function App and the underlying storage account used.

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+
- Azure Resource Group
- Azure Application Service Plan
- Azure Application Insights

## Arguments and defaults

| Name | Type | Default | Description |
|-|-|-|-|
| `name` | `string` | | **Required** Specifies the name of the Function App. Changing this forces a new resource to be created. The final name of the resource will follow this syntax `func-{var.name}-{var.project}-{var.organisation}-${var.environment}` and be lowercased. |
| `organisation_name` | `string` | | **Required** (Required) The name of your organisation. |
| `project_name` | `string` | | **Required** (Required) The name of your project. |
| `environment_short` | `string` | | **Required** (Required) The short value name of your environment. |
| `resource_group_name` | `string` | | **Required** (Required) The name of the resource group in which to create the Function App. |
| `location` | `string` | | **Required** Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `app_service_plan_id` | `string` | | **Required** The ID of the App Service Plan within which to create this Function App. |
| `application_insights_instrumentation_key` | `string` | | **Required** The application insights instrumentation key for which data is to be logged into. |
| `application_insights_id` | `string` | | **Required** The application insights instrumentation id for which data is to be logged into. |
| `app_settings` | `string` | {} | The application insights instrumentation id for which data is to be logged into. |
| `connection_strings` | `string` | {} | (Optional) A map of key-value pairs for App Settings and custom values. |
| `always_on` | `string` | `false` | (Optional) Should the Function App be loaded at all times? Defaults to false. |
| `tags` | `string` | `{}` | (Optional) A mapping of tags to assign to the resource. |
| `dependencies` | `string` | `[]` | (Optional) A mapping of dependencies which this module depends on. |

## Usage

```ruby
module function_app_example { 
  source                                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/function-app?ref=3.1.0"
  name                                      = "example-name"
  organisation_name                         = "example-organisation"
  project_name                              = "example-project"
  environment_short                         = "u"
  resource_group_name                       = "rg-example"
  location                                  = "westeurope"
  app_service_plan_id                       = "id-example"
  application_insights_instrumentation_key  = "app-insights-instrumentation-key-example"
  app_settings                              = {
    "example-key1" = "example-value1"
    "example-key2" = "example-value2"
  }
  connection_strings                        = {
    connectionstring1 = "connectionstring1"
    connectionstring2 = "connectionstring2"
  }

  tags                                      = {}

  dependencies                              = [
    module.plan_app_example.dependent_on,
    module.app_insights_example.dependent_on,
  ]
}
```

Two tags is added by default

```ruby
locals {
   module_tags = {
        "ModuleVersion" = "3.1.0"   
    }
}
```

## Outputs

| Name | Description |
|-|-|
| `id` | The ID of the Function App. |
| `name` | The name of the Function App. |
| `dependent_on` | The dependencies of the Function App. |
| `default_hostname` | The default hostname associated with the Function App - such as mysite.azurewebsites.net |
| `outbound_ip_addresses` | A comma separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12 |
| `possible_outbound_ip_addresses` | A comma separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12,52.143.43.17 - not all of which are necessarily in use. Superset of outbound_ip_addresses. |
| `identity` | An identity block as defined below, which contains the Managed Service Identity information for this App Service. |
| `site_credential` | A site_credential block as defined below, which contains the site-level credentials used to publish to this App Service. |
| `kind` | The Function App kind - such as functionapp,linux,container |
