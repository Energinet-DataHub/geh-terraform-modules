# Azure Api Management Api Operation

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure API Management API Operation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation)
- [Azure API Management API Operation Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "api_management_api_operation_example" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management-api-operation?ref=7.0.0"

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

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleId"      = "api-management-api-operation"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
