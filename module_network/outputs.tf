output "snet_fend_cus_id" {
  description = "ID da subnet frontend em Central US"
  value       = azurerm_subnet.snet_fend_cus.id
}

output "snet_bend_cus_id" {
  description = "ID da subnet backend em Central US"
  value       = azurerm_subnet.snet_bend_cus.id
}

output "snet_data_cin_id" {
  description = "ID da subnet de dados em Central India"
  value       = azurerm_subnet.snet_data_cin.id
}

output "nsg_cus_name" {
  description = "Nome do NSG de Central US"
  value       = azurerm_network_security_group.nsg_cus.name
}

output "nsg_cin_name" {
  description = "Nome do NSG de Central India"
  value       = azurerm_network_security_group.nsg_cin.name
}