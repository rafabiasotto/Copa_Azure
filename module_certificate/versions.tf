terraform {
  # Versão mínima do Terraform necessária para utilizar o módulo
  required_version = ">= 1.15.5"

  required_providers {
    # Provider utilizado para criar o Key Vault e importar o certificado
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.75.0, < 5.0.0"
    }

    # Provider utilizado para gerar a chave privada da conta ACME
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0, < 5.0.0"
    }

    # Provider utilizado para emitir o certificado pelo Let's Encrypt
    acme = {
      source  = "vancluever/acme"
      version = ">= 2.16.1, < 3.0.0"
    }
  }
}