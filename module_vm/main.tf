# IP público da VM frontend em Central US
resource "azurerm_public_ip" "pip_fend_cus" {
  name                = "pip-${var.vm_name_fend_cus}"
  location            = var.rg_location_cus
  resource_group_name = var.rg_name_cus
  allocation_method   = "Static"
  sku                 = "Standard"
}

# NIC da VM frontend em Central US
resource "azurerm_network_interface" "nic_fend_cus" {
  name                = "nic-${var.vm_name_fend_cus}"
  location            = var.rg_location_cus
  resource_group_name = var.rg_name_cus

  ip_configuration {
    name                          = "ipconfig-fend-cus"
    subnet_id                     = var.snet_fend_cus_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_fend_cus.id
  }
}

# VM frontend em Central US
resource "azurerm_windows_virtual_machine" "vm_fend_cus" {
  name                = var.vm_name_fend_cus
  computer_name       = "tk-fend-cus-01"
  resource_group_name = var.rg_name_cus
  location            = var.rg_location_cus
  size                = "Standard_D2s_v3"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  provision_vm_agent  = true
  patch_mode          = "AutomaticByPlatform"
  network_interface_ids = [
    azurerm_network_interface.nic_fend_cus.id,
  ]

  os_disk {
    name                 = "${var.vm_name_fend_cus}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-azure-edition"
    version   = "latest"
  }
}

# IP público da VM backend em Central US
resource "azurerm_public_ip" "pip_bend_cus" {
  name                = "pip-${var.vm_name_bend_cus}"
  location            = var.rg_location_cus
  resource_group_name = var.rg_name_cus
  allocation_method   = "Static"
  sku                 = "Standard"
}

# NIC da VM backend em Central US
resource "azurerm_network_interface" "nic_bend_cus" {
  name                = "nic-${var.vm_name_bend_cus}"
  location            = var.rg_location_cus
  resource_group_name = var.rg_name_cus

  ip_configuration {
    name                          = "ipconfig-bend-cus"
    subnet_id                     = var.snet_bend_cus_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_bend_cus.id
  }
}

# VM backend em Central US
resource "azurerm_windows_virtual_machine" "vm_bend_cus" {
  name                = var.vm_name_bend_cus
  computer_name       = "tk-bend-cus-01"
  resource_group_name = var.rg_name_cus
  location            = var.rg_location_cus
  size                = "Standard_D2s_v3"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  provision_vm_agent  = true
  patch_mode          = "AutomaticByPlatform"
  network_interface_ids = [
    azurerm_network_interface.nic_bend_cus.id,
  ]

  os_disk {
    name                 = "${var.vm_name_bend_cus}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-azure-edition"
    version   = "latest"
  }
}

# IP público da VM data em Central India
resource "azurerm_public_ip" "pip_data_cin" {
  name                = "pip-${var.vm_name_data_cin}"
  location            = var.rg_location_cin
  resource_group_name = var.rg_name_cus
  allocation_method   = "Static"
  sku                 = "Standard"
}

# NIC da VM data em Central India
resource "azurerm_network_interface" "nic_data_cin" {
  name                = "nic-${var.vm_name_data_cin}"
  location            = var.rg_location_cin
  resource_group_name = var.rg_name_cus

  ip_configuration {
    name                          = "ipconfig-data-cin"
    subnet_id                     = var.snet_data_cin_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_data_cin.id
  }
}

# VM data em Central India
resource "azurerm_windows_virtual_machine" "vm_data_cin" {
  name                = var.vm_name_data_cin
  computer_name       = "tk-data-cin-01"
  resource_group_name = var.rg_name_cus
  location            = var.rg_location_cin
  size                = "Standard_D2s_v3"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic_data_cin.id,
  ]

  os_disk {
    name                 = "${var.vm_name_data_cin}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "microsoftsqlserver"
    offer     = "sql2022-ws2022"
    sku       = "sqldev-gen2"
    version   = "latest"
  }
}

# Disco de dados LUN 0
resource "azurerm_managed_disk" "data_disk_0_cin" {
  name                 = "${var.vm_name_data_cin}_DataDisk_0"
  location             = var.rg_location_cin
  resource_group_name  = var.rg_name_cus
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 8
}

# Associação do disco LUN 0 à VM data
resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_0_cin" {
  managed_disk_id    = azurerm_managed_disk.data_disk_0_cin.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm_data_cin.id
  lun                = 0
  caching            = "ReadOnly"
}

# Disco de dados LUN 1
resource "azurerm_managed_disk" "data_disk_1_cin" {
  name                 = "${var.vm_name_data_cin}_DataDisk_1"
  location             = var.rg_location_cin
  resource_group_name  = var.rg_name_cus
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 8
}

# Associação do disco LUN 1 à VM data
resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_1_cin" {
  managed_disk_id    = azurerm_managed_disk.data_disk_1_cin.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm_data_cin.id
  lun                = 1
  caching            = "None"
}

# Disco de dados LUN 2
resource "azurerm_managed_disk" "data_disk_2_cin" {
  name                 = "${var.vm_name_data_cin}_DataDisk_2"
  location             = var.rg_location_cin
  resource_group_name  = var.rg_name_cus
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 8
}

# Associação do disco LUN 2 à VM data
resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_2_cin" {
  managed_disk_id    = azurerm_managed_disk.data_disk_2_cin.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm_data_cin.id
  lun                = 2
  caching            = "ReadOnly"
}

# Configuração do SQL Server da VM data em Central India
resource "azurerm_mssql_virtual_machine" "sql_vm_data_cin" {
  virtual_machine_id = azurerm_windows_virtual_machine.vm_data_cin.id

  sql_license_type = "PAYG"

  sql_connectivity_type = "PRIVATE"
  sql_connectivity_port = 1433

  sql_connectivity_update_username = var.sql_admin_username
  sql_connectivity_update_password = var.sql_admin_password

  r_services_enabled = false
}