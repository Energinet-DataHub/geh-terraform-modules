# Azure Api Management Api

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure API Management API](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api)
- [Azure API Management API Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "apima_example" {
  source                      = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management-api?ref=6.0.0"

  name                        = "example-name"
  project_name                = "example-project-name"
  environment_short           = "p"
  environment_instance        = "001"
  resource_group_name         = "example-resource-group-name"
  api_management_name         = "example-api-management-name"
  revision                    = "1"
  authorization_server_name   = "example-oauth-server-name"
  apim_logger_id              = "example-logger-id"
  logger_sampling_percentage  = "10.0"
  logger_verbosity            = "verbose"
  path                        = "example-url-path"
  backend_service_url         = "https://some-back-service.azurewebsites.net"
  import                      = {
    content_format  = "example-content-format"
    content_value   = "example-file-content"
  }
  policies                    = [
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

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-api-management-api"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
