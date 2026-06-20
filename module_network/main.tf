# NSG compartilhado pelas duas subnets da região Central US
resource "azurerm_network_security_group" "nsg_cus" {
  name                = var.nsg_name_cus
  location            = var.rg_location_cus
  resource_group_name = var.rg_name_cus

}

# VNet Central US
resource "azurerm_virtual_network" "vnet_cus" {
  name                = var.vnet_name_cus
  address_space       = var.vnet_cidr_cus
  location            = var.rg_location_cus
  resource_group_name = var.rg_name_cus
}

# Subnet frontend em Central US
resource "azurerm_subnet" "snet_fend_cus" {
  name                 = var.snet_name_fend_cus
  resource_group_name  = var.rg_name_cus
  virtual_network_name = azurerm_virtual_network.vnet_cus.name
  address_prefixes     = var.snet_cidr_fend_cus
}

# Subnet backend em Central US
resource "azurerm_subnet" "snet_bend_cus" {
  name                 = var.snet_name_bend_cus
  resource_group_name  = var.rg_name_cus
  virtual_network_name = azurerm_virtual_network.vnet_cus.name
  address_prefixes     = var.snet_cidr_bend_cus
}

# Associação do NSG com a subnet frontend em Central US
resource "azurerm_subnet_network_security_group_association" "nsg_snet_fend_cus" {
  subnet_id                 = azurerm_subnet.snet_fend_cus.id
  network_security_group_id = azurerm_network_security_group.nsg_cus.id
}

# Associação do NSG com a subnet backend em Central US
resource "azurerm_subnet_network_security_group_association" "nsg_snet_bend_cus" {
  subnet_id                 = azurerm_subnet.snet_bend_cus.id
  network_security_group_id = azurerm_network_security_group.nsg_cus.id
}

# NSG da subnet da região Central India
resource "azurerm_network_security_group" "nsg_cin" {
  name                = var.nsg_name_cin
  location            = var.location_cin
  resource_group_name = var.rg_name_cus
}

# VNet Central India
resource "azurerm_virtual_network" "vnet_cin" {
  name                = var.vnet_name_cin
  address_space       = var.vnet_cidr_cin
  location            = var.location_cin
  resource_group_name = var.rg_name_cus
}

# Subnet data em Central India
resource "azurerm_subnet" "snet_data_cin" {
  name                 = var.snet_name_data_cin
  resource_group_name  = var.rg_name_cus
  virtual_network_name = azurerm_virtual_network.vnet_cin.name
  address_prefixes     = var.snet_cidr_data_cin
}

# Associação do NSG com a subnet data em Central India
resource "azurerm_subnet_network_security_group_association" "nsg_snet_data_cin" {
  subnet_id                 = azurerm_subnet.snet_data_cin.id
  network_security_group_id = azurerm_network_security_group.nsg_cin.id
}

# Peering entre as VNets Central US e Central India
resource "azurerm_virtual_network_peering" "peering_cus_to_cin" {
  name                      = "vnet-cus-to-vnet-cin"
  resource_group_name       = var.rg_name_cus
  virtual_network_name      = azurerm_virtual_network.vnet_cus.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_cin.id

  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "peering_cin_to_cus" {
  name                      = "vnet-cin-to-vnet-cus"
  resource_group_name       = var.rg_name_cus
  virtual_network_name      = azurerm_virtual_network.vnet_cin.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_cus.id

  allow_virtual_network_access = true
}