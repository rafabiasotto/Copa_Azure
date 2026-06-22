terraform {
  required_version = ">= 1.15.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.75.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0, < 5.0.0"
    }

    acme = {
      source  = "vancluever/acme"
      version = ">= 2.16.1, < 3.0.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy               = true
      purge_soft_deleted_certificates_on_destroy = true
      purge_soft_deleted_keys_on_destroy         = true
      purge_soft_deleted_secrets_on_destroy      = true

      recover_soft_deleted_key_vaults   = false
      recover_soft_deleted_certificates = false
      recover_soft_deleted_keys         = false
      recover_soft_deleted_secrets      = false
    }
  }
}

provider "acme" {
  server_url = var.acme_server_url
}