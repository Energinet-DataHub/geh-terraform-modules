# Azure Key Vault

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Key Vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)
- [Azure Key Vault Access Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.5+
- AzureRM provider version 2.70.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "key_vault_example" { 
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault?ref=5.1.0"

  name                       = "example-name"
  project_name               = "example-project-name"
  environment_short          = "p"
  environment_instance       = "001"
  resource_group_name        = "example-resource-group-name"
  location                   = "westeurope"
  sku_name                   = "standard"
  log_analytics_workspace_id = "example-log-analytics-workspace"
  access_policies            = [
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

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.6.0"
    "ModuleId"      = "azure-key-vault"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the Key Vault. | |
| `name` | The name of the Key Vault. | |
| `vault_uri` | The URI of the Key Vault, used for performing operations on keys and secrets. | |
