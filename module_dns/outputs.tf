# Exibe os quatro Name Servers atribuídos pelo Azure
output "name_servers" {
  description = "Servidores DNS atribuídos pelo Azure"
  value       = azurerm_dns_zone.dns_zone.name_servers
}

# Nome da zona pública criada no Azure DNS
output "dns_zone_name" {
  description = "Nome da zona pública criada no Azure DNS"
  value       = azurerm_dns_zone.dns_zone.name
}