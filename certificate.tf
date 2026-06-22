# Informações do tenant, subscription e identidade autenticada no Terraform
data "azurerm_client_config" "certificate_current" {}

# Nome wildcard utilizado no certificado
locals {
  # Nome principal do certificado emitido pelo Let's Encrypt
  certificate_common_name = "*.${var.dns_zone_name}"

  # Nome adicional para cobrir também o domínio raiz
  certificate_subject_alternative_names = [
    var.dns_zone_name
  ]

  # Hostname HTTPS configurado no IIS da VM frontend
  certificate_iis_hostname = "${var.certificate_iis_record_name}.${var.dns_zone_name}"
}

# Chave privada da conta ACME usada para registrar no Let's Encrypt
resource "tls_private_key" "acme_account_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Registro da conta ACME no Let's Encrypt
resource "acme_registration" "letsencrypt" {
  account_key_pem = tls_private_key.acme_account_key.private_key_pem
  email_address   = var.acme_email
}

# Certificado Let's Encrypt validado por DNS-01 no Azure DNS
resource "acme_certificate" "tickets" {
  account_key_pem = acme_registration.letsencrypt.account_key_pem

  common_name               = local.certificate_common_name
  subject_alternative_names = local.certificate_subject_alternative_names

  # Gera o PFX com senha para importação no Key Vault e no Windows
  certificate_p12_password = var.certificate_pfx_password

  # Não faz renovação preventiva em novos applies
  min_days_remaining = var.certificate_min_days_remaining

  # Desafio DNS-01 usando Azure DNS
  dns_challenge {
    provider = "azuredns"

    config = {
      AZURE_AUTH_METHOD         = var.acme_azure_auth_method
      AZURE_SUBSCRIPTION_ID     = data.azurerm_client_config.certificate_current.subscription_id
      AZURE_TENANT_ID           = data.azurerm_client_config.certificate_current.tenant_id
      AZURE_RESOURCE_GROUP      = azurerm_resource_group.rg_cus.name
      AZURE_ZONE_NAME           = var.dns_zone_name
      AZURE_PROPAGATION_TIMEOUT = tostring(var.acme_dns_propagation_timeout)
      AZURE_POLLING_INTERVAL    = tostring(var.acme_dns_polling_interval)
      AZURE_TTL                 = tostring(var.acme_dns_ttl)
    }
  }

  # Aguarda a zona DNS existir antes de tentar criar o TXT _acme-challenge
  depends_on = [
    module.module_dns
  ]
}

# Key Vault criado no mesmo Resource Group atual do projeto
resource "azurerm_key_vault" "certificates" {
  name                = var.key_vault_name
  location            = azurerm_resource_group.rg_cus.location
  resource_group_name = azurerm_resource_group.rg_cus.name
  tenant_id           = data.azurerm_client_config.certificate_current.tenant_id

  sku_name = var.key_vault_sku_name

  # Mantém o modelo de Access Policy para simplificar o laboratório
  rbac_authorization_enabled = false

  # Necessário para certificados no Key Vault
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days
  purge_protection_enabled   = false
}

# Permissão para o usuário/service principal que está executando o Terraform importar o certificado
resource "azurerm_key_vault_access_policy" "terraform_current" {
  key_vault_id = azurerm_key_vault.certificates.id
  tenant_id    = data.azurerm_client_config.certificate_current.tenant_id
  object_id    = data.azurerm_client_config.certificate_current.object_id

  certificate_permissions = [
    "Create",
    "Delete",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Update"
  ]

  secret_permissions = [
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Set"
  ]
}

# Importa o certificado PFX emitido pelo Let's Encrypt no Key Vault
resource "azurerm_key_vault_certificate" "tickets" {
  name         = var.key_vault_certificate_name
  key_vault_id = azurerm_key_vault.certificates.id

  certificate {
    contents = acme_certificate.tickets.certificate_p12
    password = var.certificate_pfx_password
  }

  depends_on = [
    azurerm_key_vault_access_policy.terraform_current
  ]
}