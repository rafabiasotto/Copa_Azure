# Exibe os quatro Name Servers atribuídos pelo Azure
output "name_servers" {
  description = "Servidores DNS atribuídos pelo Azure"
  value       = azurerm_dns_zone.dns_zone.name_servers
}