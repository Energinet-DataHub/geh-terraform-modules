# Azure Key Vault

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Key Vault Access Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy)

## Prerequisites

- Terraform version 1.2.2+
- AzureRM provider version 3.9.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "key_vault_access_policy_example" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-access-policy?ref=7.0.0"

  key_vault_id  = "example-key-vault-id"
  app_identity {
    tenant_id     = "example-tenant-id"
    principal_id  = "example-principal-id"
  }
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleId"      = "key-vault-access-policy"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
