# Nome do Resource Group onde os recursos serão criados
variable "resource_group_name" {
  description = "Nome do Resource Group utilizado pelo Key Vault e pela validação DNS"
  type        = string
}

# Região onde o Key Vault será criado
variable "location" {
  description = "Região do Azure utilizada para criar o Key Vault"
  type        = string
}

# Nome da zona pública gerenciada pelo Azure DNS
variable "dns_zone_name" {
  description = "Nome da zona DNS utilizada para validar e emitir o certificado"
  type        = string
}

# E-mail utilizado para registrar a conta ACME
variable "acme_email" {
  description = "E-mail utilizado para registrar a conta ACME no Let's Encrypt"
  type        = string
}

# Método de autenticação utilizado pelo ACME no Azure DNS
variable "acme_azure_auth_method" {
  description = "Método de autenticação utilizado pelo ACME para acessar o Azure DNS"
  type        = string
}

# Tempo máximo para aguardar a propagação do registro TXT
variable "acme_dns_propagation_timeout" {
  description = "Tempo máximo em segundos para aguardar a propagação do desafio DNS"
  type        = number
}

# Intervalo entre as consultas de propagação DNS
variable "acme_dns_polling_interval" {
  description = "Intervalo em segundos entre as verificações de propagação DNS"
  type        = number
}

# TTL do registro TXT temporário
variable "acme_dns_ttl" {
  description = "TTL em segundos do registro TXT temporário criado pelo desafio ACME"
  type        = number
}

# Nome globalmente único do Azure Key Vault
variable "key_vault_name" {
  description = "Nome globalmente único do Key Vault que armazenará o certificado"
  type        = string
}

# SKU utilizada pelo Azure Key Vault
variable "key_vault_sku_name" {
  description = "SKU utilizada pelo Azure Key Vault"
  type        = string
}

# Retenção do soft delete do Key Vault
variable "key_vault_soft_delete_retention_days" {
  description = "Quantidade de dias de retenção do soft delete do Key Vault"
  type        = number
}

# Nome do certificado dentro do Key Vault
variable "key_vault_certificate_name" {
  description = "Nome do certificado armazenado dentro do Azure Key Vault"
  type        = string
}

# Senha utilizada para proteger o certificado PFX
variable "certificate_pfx_password" {
  description = "Senha utilizada para proteger o certificado no formato PFX"
  type        = string
  sensitive   = true
}

# Quantidade mínima de dias restantes antes de uma nova emissão
variable "certificate_min_days_remaining" {
  description = "Quantidade mínima de dias restantes antes de o ACME solicitar outro certificado"
  type        = number
}

# Nome do registro DNS utilizado pelo site
variable "certificate_iis_record_name" {
  description = "Nome do registro DNS utilizado no binding HTTPS do IIS"
  type        = string
}