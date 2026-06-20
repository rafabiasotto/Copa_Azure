terraform {
  required_version = ">= 1.15.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.75.0"
    }
  }
}

provider "azurerm" {
  features {}
}