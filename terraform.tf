terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stoterraformstatelabs"
    container_name       = "tfstate"
    key                  = "copa-azure.terraform.tfstate"
  }
}