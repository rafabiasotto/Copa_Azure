# Recupera informações da sessão autenticada no Azure
data "azurerm_client_config" "current" {}

# Valores derivados utilizados na emissão do certificado
locals {
  # Nome principal do certificado wildcard
  certificate_common_name = "*.${var.dns_zone_name}"

  # Inclui também o domínio raiz no certificado
  certificate_subject_alternative_names = [
    var.dns_zone_name
  ]

  # Hostname utilizado no binding HTTPS do IIS
  certificate_hostname = "${var.certificate_iis_record_name}.${var.dns_zone_name}"
}

# Gera a chave privada utilizada pela conta ACME
resource "tls_private_key" "acme_account_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Registra a conta ACME no Let's Encrypt
resource "acme_registration" "letsencrypt" {
  account_key_pem = tls_private_key.acme_account_key.private_key_pem
  email_address   = var.acme_email
}

# Emite o certificado por meio do desafio DNS-01
resource "acme_certificate" "tickets" {
  # Chave privada da conta ACME
  account_key_pem = acme_registration.letsencrypt.account_key_pem

  # Certificado wildcard
  common_name = local.certificate_common_name

  # Inclui também o domínio raiz
  subject_alternative_names = local.certificate_subject_alternative_names

  # Senha utilizada para gerar o arquivo PFX
  certificate_p12_password = var.certificate_pfx_password

  # Não realiza renovação preventiva
  min_days_remaining = var.certificate_min_days_remaining

  # Validação do domínio por DNS-01 no Azure DNS
  dns_challenge {
    provider = "azuredns"

    config = {
      # Reutiliza a sessão autenticada do Azure CLI
      AZURE_AUTH_METHOD = var.acme_azure_auth_method

      # Informações da assinatura e do tenant atuais
      AZURE_SUBSCRIPTION_ID = data.azurerm_client_config.current.subscription_id
      AZURE_TENANT_ID       = data.azurerm_client_config.current.tenant_id

      # Zona DNS utilizada para o desafio
      AZURE_RESOURCE_GROUP = var.resource_group_name
      AZURE_ZONE_NAME      = var.dns_zone_name

      # Configurações de propagação do registro TXT
      AZURE_PROPAGATION_TIMEOUT = tostring(var.acme_dns_propagation_timeout)
      AZURE_POLLING_INTERVAL    = tostring(var.acme_dns_polling_interval)
      AZURE_TTL                 = tostring(var.acme_dns_ttl)
    }
  }
}

# Cria o Key Vault no Resource Group atual
resource "azurerm_key_vault" "certificates" {
  # Nome globalmente único do Key Vault
  name = var.key_vault_name

  # Região e Resource Group de destino
  location            = var.location
  resource_group_name = var.resource_group_name

  # Tenant atual
  tenant_id = data.azurerm_client_config.current.tenant_id

  # SKU do Key Vault
  sku_name = var.key_vault_sku_name

  # Utiliza Access Policies em vez de RBAC
  rbac_authorization_enabled = false

  # Retenção de itens excluídos
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days

  # Proteção contra purge desabilitada para o laboratório
  purge_protection_enabled = false
}

# Concede permissões à identidade que executa o Terraform
resource "azurerm_key_vault_access_policy" "terraform_current" {
  # Key Vault que receberá a política
  key_vault_id = azurerm_key_vault.certificates.id

  # Tenant e identidade autenticada
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  # Permissões necessárias para gerenciar certificados
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

  # Permissões necessárias para o secret associado ao certificado
  secret_permissions = [
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Set"
  ]
}

# Importa o certificado emitido pelo ACME no Azure Key Vault
resource "azurerm_key_vault_certificate" "tickets" {
  # Nome do certificado dentro do Key Vault
  name = var.key_vault_certificate_name

  # Key Vault que armazenará o certificado
  key_vault_id = azurerm_key_vault.certificates.id

  # Conteúdo e senha do certificado PFX
  certificate {
    contents = acme_certificate.tickets.certificate_p12
    password = var.certificate_pfx_password
  }

  # Aguarda a criação das permissões
  depends_on = [
    azurerm_key_vault_access_policy.terraform_current
  ]
}