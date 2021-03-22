resource "random_string" "randomstring" {
  length = 5
  special = false
}

module "plan-app" { 
  source                   = "../" 
  name                     = "plan-${random_string.randomstring.result}" 
  resource_group_name      = var.resource_group_name
  location                 = "westeurope"
  kind                     = "FunctionApp"
  tags                     = {
    test="test"
  }
  sku                 = {
    tier  = "Basic"
    size  = "B1"
  }
}

data "null_data_source" "output_and_dependency_test" {
  depends_on = [module.plan-app.depended_on]

  inputs = {
    id = module.plan-app.id,
    name = module.plan-app.name,
  }
}