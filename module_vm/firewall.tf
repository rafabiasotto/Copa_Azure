locals {
  # Desabilita o Windows Firewall e o IE Enhanced Security Configuration
  disable_windows_firewall_command = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command \"$ErrorActionPreference = 'Stop'; Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False; $adminKey = 'HKLM:\\SOFTWARE\\Microsoft\\Active Setup\\Installed Components\\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}'; $userKey = 'HKLM:\\SOFTWARE\\Microsoft\\Active Setup\\Installed Components\\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}'; if (Test-Path $adminKey) { Set-ItemProperty -Path $adminKey -Name 'IsInstalled' -Value 0 -Force }; if (Test-Path $userKey) { Set-ItemProperty -Path $userKey -Name 'IsInstalled' -Value 0 -Force }; Stop-Process -Name iexplore -Force -ErrorAction SilentlyContinue; exit 0\""

  # Desabilita o Windows Firewall e o IE Enhanced Security Configuration e instala o IIS na VM frontend
  configure_fend_cus_command = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command \"$ErrorActionPreference = 'Stop'; Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False; $adminKey = 'HKLM:\\SOFTWARE\\Microsoft\\Active Setup\\Installed Components\\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}'; $userKey = 'HKLM:\\SOFTWARE\\Microsoft\\Active Setup\\Installed Components\\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}'; if (Test-Path $adminKey) { Set-ItemProperty -Path $adminKey -Name 'IsInstalled' -Value 0 -Force }; if (Test-Path $userKey) { Set-ItemProperty -Path $userKey -Name 'IsInstalled' -Value 0 -Force }; Stop-Process -Name iexplore -Force -ErrorAction SilentlyContinue; $result = Install-WindowsFeature -Name Web-Server,Web-WebSockets,Web-Stat-Compression,Web-Dyn-Compression -IncludeManagementTools; if (-not $result.Success) { throw 'Falha ao instalar IIS e recursos adicionais na VM frontend' }; Write-Host 'OK IIS instalado na VM frontend' -ForegroundColor Green; exit 0\""

  # Desabilita o Windows Firewall e o IE Enhanced Security Configuration e instala o IIS na VM backend
  configure_bend_cus_command = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command \"$ErrorActionPreference = 'Stop'; Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False; $adminKey = 'HKLM:\\SOFTWARE\\Microsoft\\Active Setup\\Installed Components\\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}'; $userKey = 'HKLM:\\SOFTWARE\\Microsoft\\Active Setup\\Installed Components\\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}'; if (Test-Path $adminKey) { Set-ItemProperty -Path $adminKey -Name 'IsInstalled' -Value 0 -Force }; if (Test-Path $userKey) { Set-ItemProperty -Path $userKey -Name 'IsInstalled' -Value 0 -Force }; Stop-Process -Name iexplore -Force -ErrorAction SilentlyContinue; $result = Install-WindowsFeature -Name Web-Server,Web-WebSockets,Web-Stat-Compression,Web-Dyn-Compression -IncludeManagementTools; if (-not $result.Success) { throw 'Falha ao instalar IIS e recursos adicionais na VM backend' }; Write-Host 'OK IIS instalado na VM backend' -ForegroundColor Green; exit 0\""
}

# Desabilita o Windows Firewall e o IE Enhanced Security Configuration e instala o IIS na VM frontend em Central US
resource "azurerm_virtual_machine_extension" "disable_firewall_fend_cus" {
  name                       = "disable-windows-firewall"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm_fend_cus.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    commandToExecute = local.configure_fend_cus_command
  })
}

# Desabilita o Windows Firewall e o IE Enhanced Security Configuration e instala o IIS na VM backend em Central US
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

# Desabilita o Windows Firewall e o IE Enhanced Security Configuration na VM data em Central India
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