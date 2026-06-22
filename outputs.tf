# IP público da VM Frontend em Central US
output "vm_public_ip_fend_cus" {
  description = "IP público da VM frontend em Central US"
  value       = module.module_vm.vm_public_ip_fend_cus
}

# IP público da VM Backend em Central US
output "vm_public_ip_bend_cus" {
  description = "IP público da VM backend em Central US"
  value       = module.module_vm.vm_public_ip_bend_cus
}

# IP público da VM Data em Central India
output "vm_public_ip_data_cin" {
  description = "IP público da VM data em Central India"
  value       = module.module_vm.vm_public_ip_data_cin
}

# Exibe os quatro Name Servers para configuração no gerenciador do domínio
output "dns_name_servers" {
  description = "Servidores DNS atribuídos pelo Azure DNS"
  value       = module.module_dns.name_servers
}

# Nome do Key Vault criado para armazenar o certificado
output "certificate_key_vault_name" {
  description = "Nome do Key Vault que armazena o certificado HTTPS"
  value       = module.module_certificate.key_vault_name
}

# URI do Key Vault criado para armazenar o certificado
output "certificate_key_vault_uri" {
  description = "URI do Key Vault que armazena o certificado HTTPS"
  value       = module.module_certificate.key_vault_uri
}

# Nome do certificado armazenado no Key Vault
output "certificate_key_vault_certificate_name" {
  description = "Nome do certificado importado no Key Vault"
  value       = module.module_certificate.key_vault_certificate_name
}

# ID completo do certificado armazenado no Key Vault
output "certificate_key_vault_certificate_id" {
  description = "ID do certificado armazenado no Key Vault"
  value       = module.module_certificate.key_vault_certificate_id
}

# Hostname configurado no binding HTTPS do IIS
output "certificate_iis_hostname" {
  description = "Hostname configurado no binding HTTPS da VM Frontend"
  value       = module.module_certificate.certificate_hostname
}

# Data de expiração do certificado
output "certificate_not_after" {
  description = "Data de expiração do certificado emitido pelo Let's Encrypt"
  value       = module.module_certificate.certificate_not_after
}