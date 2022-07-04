# Azure Key Vault Secret

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Key Vault Secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret)

## Prerequisites

- Terraform version 1.2.2+
- AzureRM provider version 3.9.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "key_vault_secret_example" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "EXAMPLE-NAME"
  value         = "example-value"
  key_vault_id  = "example-key-vault-id"

  tags          = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleId"      = "azure-key-vault-secret"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
