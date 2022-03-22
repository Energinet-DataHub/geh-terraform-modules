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

See [variables.tf](./variables.tf)

## Usage

```ruby
module "apima_example" { 
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management-api?ref=5.1.0"

  name                      = "example-name"
  project_name              = "example-project-name"
  environment_short         = "p"
  environment_instance      = "001"
  resource_group_name       = "example-resource-group-name"
  api_management_name       = "example-api-management-name"
  revision                  = "1"
  authorization_server_name = "example-oauth-server-name"
  policies                  = [
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
    "ModuleVersion" = "5.1.0"
    "ModuleId"      = "azure-api-management-api"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the API Management API. | |
| `name` | The name of the API Management API. | |
