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

See [variables.tf](./variables.tf)

## Usage

```ruby
module "key_vault_secret_example" { 
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.1.0"

  name          = "EXAMPLE-NAME"
  value         = "example-value"
  key_vault_id  = "example-key-vault-id"

  tags          = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.1.0"
    "ModuleId"      = "azure-key-vault-secret"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The Key Vault Secret ID. | |
| `name` | The Key Vault Secret name. | |
| `version` | The current version of the Key Vault Secret. | |
| `value` | The Key Vault Secret value. | `true` |
