# Nome do Key Vault criado para armazenar o certificado
output "certificate_key_vault_name" {
  description = "Nome do Key Vault que armazena o certificado HTTPS"
  value       = azurerm_key_vault.certificates.name
}

# URI do Key Vault criado para armazenar o certificado
output "certificate_key_vault_uri" {
  description = "URI do Key Vault que armazena o certificado HTTPS"
  value       = azurerm_key_vault.certificates.vault_uri
}

# Nome do certificado armazenado no Key Vault
output "certificate_key_vault_certificate_name" {
  description = "Nome do certificado importado no Key Vault"
  value       = azurerm_key_vault_certificate.tickets.name
}

# Hostname configurado no binding HTTPS do IIS
output "certificate_iis_hostname" {
  description = "Hostname configurado no binding HTTPS da VM frontend"
  value       = local.certificate_iis_hostname
}