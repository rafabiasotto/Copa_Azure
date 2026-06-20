# Resource group da região Central US
resource "azurerm_resource_group" "rg_cus" {
  name     = var.rg_name_cus
  location = var.rg_location_cus
}

module "module_network" {
  source = "./module_network"

  rg_name_cus     = azurerm_resource_group.rg_cus.name
  rg_location_cus = azurerm_resource_group.rg_cus.location

  nsg_name_cus       = var.nsg_name_cus
  vnet_name_cus      = var.vnet_name_cus
  vnet_cidr_cus      = var.vnet_cidr_cus
  snet_name_fend_cus = var.snet_name_fend_cus
  snet_cidr_fend_cus = var.snet_cidr_fend_cus
  snet_name_bend_cus = var.snet_name_bend_cus
  snet_cidr_bend_cus = var.snet_cidr_bend_cus

  location_cin       = var.location_cin
  nsg_name_cin       = var.nsg_name_cin
  vnet_name_cin      = var.vnet_name_cin
  vnet_cidr_cin      = var.vnet_cidr_cin
  snet_name_data_cin = var.snet_name_data_cin
  snet_cidr_data_cin = var.snet_cidr_data_cin
}

module "module_vm" {
  source = "./module_vm"

  rg_name_cus     = azurerm_resource_group.rg_cus.name
  rg_location_cus = azurerm_resource_group.rg_cus.location

  snet_fend_cus_id = module.module_network.snet_fend_cus_id

  vm_name_fend_cus = var.vm_name_fend_cus
  admin_username   = var.admin_username
  admin_password   = var.admin_password

  snet_bend_cus_id = module.module_network.snet_bend_cus_id
  vm_name_bend_cus = var.vm_name_bend_cus

  snet_data_cin_id = module.module_network.snet_data_cin_id
  vm_name_data_cin = var.vm_name_data_cin
  rg_location_cin  = var.location_cin

  sql_admin_username = var.sql_admin_username
  sql_admin_password = var.sql_admin_password
}

resource "azurerm_network_security_rule" "allow_rdp_fend_cus" {
  name                   = "Allow_RDP_CUS"
  priority               = 300
  direction              = "Inbound"
  access                 = "Allow"
  protocol               = "Tcp"
  source_port_range      = "*"
  destination_port_range = "3389"
  source_address_prefix  = "*"
  destination_address_prefixes = [
    module.module_vm.vm_private_ip_fend_cus,
    module.module_vm.vm_private_ip_bend_cus
  ]
  resource_group_name         = azurerm_resource_group.rg_cus.name
  network_security_group_name = module.module_network.nsg_cus_name
}

resource "azurerm_network_security_rule" "allow_rdp_data_cin" {
  name                        = "Allow_RDP_CIN"
  priority                    = 310
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = module.module_vm.vm_private_ip_data_cin
  resource_group_name         = azurerm_resource_group.rg_cus.name
  network_security_group_name = module.module_network.nsg_cin_name
}