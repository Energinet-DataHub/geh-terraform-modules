# Azure Key Vault

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Key Vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)
- [Azure Key Vault Access Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy)
- [Azure Private Endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "key_vault_example" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault?ref=6.0.0"

  name                            = "example-name"
  project_name                    = "example-project-name"
  environment_short               = "u"
  environment_instance            = "001"
  resource_group_name             = "example-resource-group-name"
  location                        = "westeurope"
  sku_name                        = "standard"
  private_endpoint_subnet_id      = "private-endpoint-subnet-id"
  log_analytics_workspace_id      = "example-log-analytics-workspace"

  access_policies       = [
    {
      object_id               = "example-object-id"
      secret_permissions      = ["backup", "delete", "get"]
      certificate_permissions = ["backup", "create", "delete"]
      key_permissions         = ["backup", "create", "decrypt"]
      storage_permissions     = ["backup", "delete", "deletesas"]
    },
    {
      object_id               = "example-object-id"
      secret_permissions      = ["backup", "delete"]
      certificate_permissions = ["backup", "create"]
      key_permissions         = ["backup", "create"]
      storage_permissions     = ["backup", "delete"]
    }
  ]
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-key-vault"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
