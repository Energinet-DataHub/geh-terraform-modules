# Monitor Action Group Email

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Monitor Action Group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group)

## Prerequisites

- Terraform version 1.1.7+
- AzureRM provider version 2.97.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "monitor_action_group_email_example" {
  source                                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/monitor-action-group-email?ref=5.8.0"

  name                                      = "example-name"
  project_name                              = "example-project-name"
  environment_short                         = "u"
  environment_instance                      = "001"
  resource_group_name                       = "example-resource-group-name"

  short_name                                = "max12chars"
  email_receiver_name                       = "example receiver"
  email_receiver_address                    = "mail@example.com"

  tags                                      = {}
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleId"      = "monitor-action-group-email"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
