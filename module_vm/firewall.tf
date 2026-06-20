locals {
  # Desabilita o Windows Firewall
  disable_windows_firewall_command = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command \"Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False; exit 0\""

  # Desabilita o Windows Firewall e instala o IIS na VM backend
  configure_bend_cus_command = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command \"$ErrorActionPreference = 'Stop'; Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False; $result = Install-WindowsFeature -Name Web-Server,Web-WebSockets,Web-Stat-Compression,Web-Dyn-Compression -IncludeManagementTools; if (-not $result.Success) { throw 'Falha ao instalar IIS e recursos adicionais' }; Write-Host 'OK IIS instalado' -ForegroundColor Green; exit 0\""
}

# Desabilita o Windows Firewall na VM frontend em Central US
resource "azurerm_virtual_machine_extension" "disable_firewall_fend_cus" {
  name                       = "disable-windows-firewall"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm_fend_cus.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    commandToExecute = local.disable_windows_firewall_command
  })
}

# Desabilita o Windows Firewall e instala o IIS na VM backend em Central US
resource "azurerm_virtual_machine_extension" "configure_bend_cus" {
  name                       = "configure-windows-bend"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm_bend_cus.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    commandToExecute = local.configure_bend_cus_command
  })
}

# Desabilita o Windows Firewall na VM data em Central India
resource "azurerm_virtual_machine_extension" "disable_firewall_data_cin" {
  name                       = "disable-windows-firewall"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm_data_cin.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    commandToExecute = local.disable_windows_firewall_command
  })
}