# Azure Api Management Api

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure API Management API](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api)
- [Azure API Management API Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the API Management API. Changing this forces a new resource to be created. The final name of the resource will follow this syntax `apima-{var.name}-${var.project_name}-${var.environment_short}-${var.environment_instance}` and be in lowercase. |
| `project_name` | `string` | | **Required** | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The Name of the Resource Group where the API Management API exists. Changing this forces a new resource to be created. |
| `api_management_name` | `string` | | **Required** | The Name of the API Management Service where this API should be created. Changing this forces a new resource to be created. |
| `revision` | `string` | | **Required** | The Revision which used for this API. |
| `display_name` | `string` | | | The display name of the API. |
| `protocols` | `list(string)` | `["https"]` | | A list of protocols the operations in this API can be invoked. Possible values are http and https. |
| `subscription_required` | `boolean` | `false` | | Should this API require a subscription key |
| `policies` | `list` | `[]` | | A list of objects describing the API policies. See [Policy](#policy). |

### Policies

A `policies` item consists of the following:

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `xml_content` | `string` | | | The XML Content for this Policy as a string. An XML file can be used here with Terraform's [file function](https://www.terraform.io/docs/configuration/functions/file.html?_ga=2.22559163.1256853139.1634111402-2030691422.1630398976) that is similar to Microsoft's `PolicyFilePath` option. |

## Usage

```ruby
module "api_management_api_example" { 
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management-api?ref=4.1.0"

  name                  = "example-name"
  project_name          = "example-project-name"
  environment_short     = "p"
  environment_instance  = "001"
  resource_group_name   = "example-resource-group-name"
  api_management_name   = "example-api-management-name"
  revision              = "1"
  policies              = [
    {
      xml_content = <<XML
        <policies>
          <inbound>
            <find-and-replace from="xyz" to="abc" />
          </inbound>
        </policies>
        XML
    }
  ]
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.0.0"
    "ModuleId"      = "azure-api-management-api"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the API Management API. | |
| `name` | The name of the API Management API. | |
