# Azure Key Vault Secret

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Key Vault Secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created. |
| `value` | `string` | | **Required** | Specifies the value of the Key Vault Secret. |
| `key_vault_id` | `string` | | **Required** | The ID of the Key Vault where the Secret should be created. |
| `tags` | `any` | `{}` | | A mapping of tags to assign to the resource. |
| `dependencies` | `string` | `[]` | | A mapping of dependencies which this module depends on. |

## Usage

```ruby
module "key_vault_secret_example" { 
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=3.1.0"

  name          = "EXAMPLE-NAME"
  value         = "example-value"
  key_vault_id  = "example-key-vault-id"

  tags          = {}

  dependencies  = [
    module.example.dependent_on,
  ]
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "3.1.0"
    "ModuleId"      = "key-vault-secret"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The Key Vault Secret ID. | |
| `name` | The Key Vault Secret name. | |
| `dependent_on` | The Key Vault Secret dependencies. | |
| `version` | The current version of the Key Vault Secret. | |
| `value` | The Key Vault Secret value. | `true` |
