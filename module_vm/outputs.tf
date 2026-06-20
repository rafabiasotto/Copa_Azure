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

output "vm_public_ip_fend_cus" {
  description = "IP público da VM frontend em Central US"
  value       = azurerm_public_ip.pip_fend_cus.ip_address
}

output "vm_public_ip_bend_cus" {
  description = "IP público da VM backend em Central US"
  value       = azurerm_public_ip.pip_bend_cus.ip_address
}

output "vm_public_ip_data_cin" {
  description = "IP público da VM data em Central India"
  value       = azurerm_public_ip.pip_data_cin.ip_address
}