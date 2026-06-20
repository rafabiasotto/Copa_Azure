output "vm_public_ip_fend_cus" {
  description = "IP público da VM frontend em Central US"
  value       = module.module_vm.vm_public_ip_fend_cus
}

output "vm_public_ip_bend_cus" {
  description = "IP público da VM backend em Central US"
  value       = module.module_vm.vm_public_ip_bend_cus
}

output "vm_public_ip_data_cin" {
  description = "IP público da VM data em Central India"
  value       = module.module_vm.vm_public_ip_data_cin
}

# Exibe os quatro Name Servers para configuração na Hostinger
output "dns_name_servers" {
  description = "Servidores DNS atribuídos pelo Azure"
  value       = module.module_dns.name_servers
}