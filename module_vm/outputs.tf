output "vm_private_ip_fend_cus" {
  description = "IP privado da VM frontend em Central US"
  value       = azurerm_network_interface.nic_fend_cus.private_ip_address
}

output "vm_private_ip_bend_cus" {
  description = "IP privado da VM backend em Central US"
  value       = azurerm_network_interface.nic_bend_cus.private_ip_address
}

output "vm_private_ip_data_cin" {
  description = "IP privado da VM data em Central India"
  value       = azurerm_network_interface.nic_data_cin.private_ip_address
}