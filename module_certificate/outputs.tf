# Certificado PFX utilizado pela VM Frontend
output "certificate_p12" {
  description = "Certificado PFX emitido pelo provider ACME"
  value       = acme_certificate.tickets.certificate_p12
  sensitive   = true
}

# Hostname completo utilizado no binding HTTPS
output "certificate_hostname" {
  description = "Hostname completo utilizado no binding HTTPS do IIS"
  value       = local.certificate_hostname
}

# Nome do Key Vault
output "key_vault_name" {
  description = "Nome do Key Vault que armazena o certificado"
  value       = azurerm_key_vault.certificates.name
}

# URI do Key Vault
output "key_vault_uri" {
  description = "URI do Key Vault que armazena o certificado"
  value       = azurerm_key_vault.certificates.vault_uri
}

# Nome do certificado armazenado no Key Vault
output "key_vault_certificate_name" {
  description = "Nome do certificado armazenado no Azure Key Vault"
  value       = azurerm_key_vault_certificate.tickets.name
}

# ID completo do certificado armazenado no Key Vault
output "key_vault_certificate_id" {
  description = "ID completo do certificado armazenado no Azure Key Vault"
  value       = azurerm_key_vault_certificate.tickets.id
}

# Data de expiração do certificado
output "certificate_not_after" {
  description = "Data de expiração do certificado emitido pelo ACME"
  value       = acme_certificate.tickets.certificate_not_after
}