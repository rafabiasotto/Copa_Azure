locals {
  # Gera o script completo de configuração da VM Data
  configure_data_cin_script = templatefile(
    "${path.module}/scripts/configure-data.ps1.tftpl",
    {
      # URL do BACPAC da aplicação
      bacpac_url_b64 = base64encode(var.data_bacpac_url)

      # URL do SqlPackage ZIP standalone
      sqlpackage_zip_url_b64 = base64encode(var.sqlpackage_zip_url)

      # Nome do banco utilizado pela aplicação
      database_name_b64 = base64encode(var.backend_database_name)

      # Credenciais SQL configuradas na SQL Virtual Machine
      database_username_b64 = base64encode(var.sql_admin_username)
      database_password_b64 = base64encode(var.sql_admin_password)

      # Quantidades esperadas para validação pós-importação
      expected_matches_count  = var.data_expected_matches_count
      expected_stadiums_count = var.data_expected_stadiums_count
      expected_teams_count    = var.data_expected_teams_count
    }
  )

  # Converte o script completo da VM Data para Base64
  configure_data_cin_script_base64 = base64encode(
    local.configure_data_cin_script
  )

  # Reconstrói e executa o script de configuração dentro da VM Data
  configure_data_cin_command = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command \"$scriptPath = 'C:\\Windows\\Temp\\configure-data.ps1'; $content = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${local.configure_data_cin_script_base64}')); Set-Content -Path $scriptPath -Value $content -Encoding UTF8 -Force; & powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File $scriptPath; exit $LASTEXITCODE\""

  # Gera o script completo de configuração da VM backend
  configure_bend_cus_script = templatefile(
    "${path.module}/scripts/configure-backend.ps1.tftpl",
    {
      # URLs dos arquivos necessários para a VM backend
      backend_zip_url_b64     = base64encode(var.backend_zip_url)
      iisnode_msi_url_b64     = base64encode(var.iisnode_msi_url)
      url_rewrite_msi_url_b64 = base64encode(var.url_rewrite_msi_url)

      # Configurações do site e Application Pool do backend
      backend_site_name_b64     = base64encode(var.backend_site_name)
      backend_app_pool_name_b64 = base64encode(var.backend_app_pool_name)
      backend_app_path_b64      = base64encode(var.backend_app_path)

      # IP privado dinâmico da VM Data
      database_private_ip_b64 = base64encode(
        azurerm_network_interface.nic_data_cin.private_ip_address
      )

      # Configurações de acesso ao banco SQL
      database_name_b64     = base64encode(var.backend_database_name)
      database_username_b64 = base64encode(var.sql_admin_username)
      database_password_b64 = base64encode(var.sql_admin_password)

      # Configurações da aplicação Node.js
      backend_host_b64     = base64encode(var.backend_host)
      jwt_secret_b64       = base64encode(var.backend_jwt_secret)
      jwt_expires_in_b64   = base64encode(var.backend_jwt_expires_in)
      frontend_url_b64     = base64encode(var.backend_frontend_url)
      healthcheck_path_b64 = base64encode(var.backend_healthcheck_path)

      # Versão do Node.js e porta da API
      node_major_version = var.node_major_version
      backend_port       = var.backend_port
    }
  )

  # Converte o script completo da VM backend para Base64
  configure_bend_cus_script_base64 = base64encode(
    local.configure_bend_cus_script
  )

  # Reconstrói e executa o script de configuração dentro da VM backend
  configure_bend_cus_command = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command \"$scriptPath = 'C:\\Windows\\Temp\\configure-backend.ps1'; $content = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${local.configure_bend_cus_script_base64}')); Set-Content -Path $scriptPath -Value $content -Encoding UTF8 -Force; & powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File $scriptPath; exit $LASTEXITCODE\""

  # Gera o script completo de configuração da VM frontend
  configure_fend_cus_script = templatefile(
    "${path.module}/scripts/configure-frontend.ps1.tftpl",
    {
      # URLs dos arquivos necessários para a VM frontend
      frontend_zip_url_b64    = base64encode(var.frontend_zip_url)
      url_rewrite_msi_url_b64 = base64encode(var.url_rewrite_msi_url)

      external_cache_msi_url_b64 = base64encode(
        var.external_cache_msi_url
      )

      arr_msi_url_b64 = base64encode(var.arr_msi_url)

      # Configurações do site e Application Pool do frontend
      frontend_site_name_b64     = base64encode(var.frontend_site_name)
      frontend_app_pool_name_b64 = base64encode(var.frontend_app_pool_name)
      frontend_app_path_b64      = base64encode(var.frontend_app_path)

      # IP privado dinâmico da VM backend
      backend_private_ip_b64 = base64encode(
        azurerm_network_interface.nic_bend_cus.private_ip_address
      )

      # Placeholder do web.config que receberá o endereço do backend
      backend_placeholder_b64 = base64encode(
        var.frontend_backend_placeholder
      )

      # Endpoints utilizados nos testes HTTP
      frontend_healthcheck_path_b64 = base64encode(
        var.frontend_healthcheck_path
      )

      proxy_healthcheck_path_b64 = base64encode(
        var.frontend_proxy_healthcheck_path
      )

      # Configurações HTTPS do frontend
      frontend_https_enabled       = var.frontend_https_enabled
      certificate_pfx_base64_b64   = base64encode(var.frontend_certificate_pfx_base64)
      certificate_pfx_password_b64 = base64encode(var.frontend_certificate_pfx_password)
      certificate_hostname_b64     = base64encode(var.frontend_certificate_hostname)
      https_healthcheck_path_b64   = base64encode(var.frontend_https_healthcheck_path)

      # Portas utilizadas pelo frontend e backend
      frontend_port = var.frontend_port
      backend_port  = var.backend_port
    }
  )

  # Converte o script completo da VM frontend para Base64
  configure_fend_cus_script_base64 = base64encode(
    local.configure_fend_cus_script
  )

  # Reconstrói e executa o script de configuração dentro da VM frontend
  configure_fend_cus_command = "powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command \"$scriptPath = 'C:\\Windows\\Temp\\configure-frontend.ps1'; $content = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${local.configure_fend_cus_script_base64}')); Set-Content -Path $scriptPath -Value $content -Encoding UTF8 -Force; & powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File $scriptPath; exit $LASTEXITCODE\""
}

# Configura a VM Data com validação do SQL Server, download do BACPAC e importação do banco
resource "azurerm_virtual_machine_extension" "configure_data_cin" {
  name                       = "configure-windows-data"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm_data_cin.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  # Usa protected_settings porque o script contém usuário e senha SQL
  protected_settings = jsonencode({
    commandToExecute = local.configure_data_cin_command
  })

  # Aguarda a configuração do SQL Virtual Machine antes da importação do BACPAC
  depends_on = [
    azurerm_mssql_virtual_machine.sql_vm_data_cin
  ]
}

# Configura completamente a VM backend com IIS, Node.js, iisnode, aplicação e arquivo .env
resource "azurerm_virtual_machine_extension" "configure_bend_cus" {
  name                       = "configure-windows-bend"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm_bend_cus.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  # Usa protected_settings porque o script contém senha SQL e segredo JWT
  protected_settings = jsonencode({
    commandToExecute = local.configure_bend_cus_command
  })

  # Aguarda a VM Data importar e validar o banco
  depends_on = [
    azurerm_virtual_machine_extension.configure_data_cin
  ]
}

# Configura completamente a VM frontend com IIS, URL Rewrite, ARR, aplicação web e HTTPS
resource "azurerm_virtual_machine_extension" "configure_fend_cus" {
  name                       = "configure-windows-fend"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm_fend_cus.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  # Usa protected_settings porque o script contém certificado PFX e senha do PFX
  protected_settings = jsonencode({
    commandToExecute = local.configure_fend_cus_command
  })

  # Aguarda a configuração da VM backend antes de configurar o proxy e o HTTPS
  depends_on = [
    azurerm_virtual_machine_extension.configure_bend_cus
  ]
}