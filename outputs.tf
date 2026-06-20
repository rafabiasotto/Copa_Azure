output "vm_public_ip_fend_cus" {
  description = "IP público da VM frontend em Central US"
  value       = azurerm_network_interface.nic_fend_cus.public_ip_address
}

output "vm_public_ip_bend_cus" {
  description = "IP público da VM backend em Central US"
  value       = azurerm_network_interface.nic_bend_cus.public_ip_address
}

output "vm_public_ip_data_cin" {
  description = "IP público da VM data em Central India"
  value       = azurerm_network_interface.nic_data_cin.public_ip_address
}