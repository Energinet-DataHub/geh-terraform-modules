# Azure Api Management Api Operation

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure API Management API Operation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation)
- [Azure API Management API Operation Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `resource_group_name` | `string` | | **Required** | The Name of the Resource Group in which the API Management Service exists. Changing this forces a new resource to be created. The final name will be lowercased. |
| `operation_id` | `string` | | **Required** | A unique identifier for this API Operation. Changing this forces a new resource to be created. |
| `api_management_api_name` | `string` | | **Required** | The name of the API within the API Management Service where this API Operation should be created. Changing this forces a new resource to be created. |
| `api_management_name` | `string` | | **Required** | The Name of the API Management Service where the API exists. Changing this forces a new resource to be created. |
| `display_name` | `string` | | **Required** | The Display Name for this API Management Operation. |
| `method` | `string` | | **Required** | The HTTP Method used for this API Management Operation, like `GET`, `DELETE`, `PUT` or `POST` - but not limited to these values. |
| `url_template` | `string` | | **Required** | The relative URL Template identifying the target resource for this operation, which may include parameters. |
| `description` | `string` | | | A description for this API Operation, which may include HTML formatting tags. |
| `policies` | `list` | `[]` | |  A list of objects describing the API operation policies. See [Policy](#policy). |

### Policies

A `policies` item consists of the following:

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `xml_content` | `string` | | | The XML Content for this Policy as a string. An XML file can be used here with Terraform's [file function](https://www.terraform.io/docs/configuration/functions/file.html?_ga=2.22559163.1256853139.1634111402-2030691422.1630398976) that is similar to Microsoft's `PolicyFilePath` option. |

## Usage

```ruby
module "api_management_api_operation_example" { 
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management-api-operation?ref=4.1.0"

  operation_id        = "example-operation-id"
  api_name            = "example-api-management-api-name"
  resource_group_name = "example-resource-group-name"
  api_management_name = "example-api-management-name"
  display_name        = "example-display-name"
  method              = "POST"
  url_template        = "/create"
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

  tags                = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.0.0"
    "ModuleId"      = "api-management-api-operation"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the API Management API Operation. | |
| `dependent_on` | The dependencies of the API Management API Operation component. | |
