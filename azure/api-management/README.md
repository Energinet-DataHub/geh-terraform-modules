# Azure Api Management

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Api Management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the Function App. Changing this forces a new resource to be created. The final name of the resource will follow this syntax `appi-{var.name}-${var.environment_short}-${var.environment_instance}` and be in lowercase. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the Resource Group in which the API Management Service should be exist. Changing this forces a new resource to be created.|
| `location` | `string` | | **Required** | The Azure location where the API Management Service exists. Changing this forces a new resource to be created. |
| `publisher_name` | `string` | | **Required** | The name of publisher/company. |
| `publisher_email` | `string` | | **Required** | The email of publisher/company. |
| `sku_name` | `string` | | **Required** | sku_name is a string consisting of two parts separated by an underscore(_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1). |
| `tags` | `any` | `{}` | | A mapping of tags to assign to the resource. |
| `dependencies` | `string` | `[]` | | A mapping of dependencies which this module depends on. |

## Usage

```ruby
module "api_management_example" { 
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management?ref=3.1.0"

  name                  = "example-name"
  environment_short     = ""
  environment_instance  = "001"
  resource_group_name   = "example-resource-group-name"
  location              = "westeurope"
  publisher_name        = "John Doe"
  publisher_email       = "johndoe@example.com"
  sku_name              = "Developer_1"

  dependencies          = [
    module.example.dependent_on,
  ]
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "3.1.0"
    "ModuleId"      = "azure-api-management"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the API Management Service. | |
| `name` | The name of the API Management Service. | |
| `dependent_on` | The dependencies of the API Management Service. | |
