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

      # Quantidades esperadas para validação após a importação
      expected_matches_count  = var.data_expected_matches_count
      expected_stadiums_count = var.data_expected_stadiums_count
      expected_teams_count    = var.data_expected_teams_count
    }
  )

  # Gera o script completo de configuração da VM Backend
  configure_bend_cus_script = templatefile(
    "${path.module}/scripts/configure-backend.ps1.tftpl",
    {
      # URLs dos arquivos necessários para configurar o backend
      backend_zip_url_b64     = base64encode(var.backend_zip_url)
      iisnode_msi_url_b64     = base64encode(var.iisnode_msi_url)
      url_rewrite_msi_url_b64 = base64encode(var.url_rewrite_msi_url)

      # Configurações do site e Application Pool do backend
      backend_site_name_b64     = base64encode(var.backend_site_name)
      backend_app_pool_name_b64 = base64encode(var.backend_app_pool_name)
      backend_app_path_b64      = base64encode(var.backend_app_path)

      # IP privado atribuído dinamicamente à VM Data
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

  # Gera o script completo de configuração da VM Frontend
  configure_fend_cus_script = templatefile(
    "${path.module}/scripts/configure-frontend.ps1.tftpl",
    {
      # URLs dos arquivos necessários para configurar o frontend
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

      # IP privado atribuído dinamicamente à VM Backend
      backend_private_ip_b64 = base64encode(
        azurerm_network_interface.nic_bend_cus.private_ip_address
      )

      # Placeholder que será substituído no web.config
      backend_placeholder_b64 = base64encode(
        var.frontend_backend_placeholder
      )

      # Endpoints usados nos testes HTTP
      frontend_healthcheck_path_b64 = base64encode(
        var.frontend_healthcheck_path
      )

      proxy_healthcheck_path_b64 = base64encode(
        var.frontend_proxy_healthcheck_path
      )

      # Configurações HTTPS do frontend
      frontend_https_enabled = var.frontend_https_enabled

      certificate_pfx_base64_b64 = base64encode(
        var.frontend_certificate_pfx_base64
      )

      certificate_pfx_password_b64 = base64encode(
        var.frontend_certificate_pfx_password
      )

      certificate_hostname_b64 = base64encode(
        var.frontend_certificate_hostname
      )

      https_healthcheck_path_b64 = base64encode(
        var.frontend_https_healthcheck_path
      )

      # Portas utilizadas pelo frontend e pelo backend
      frontend_port = var.frontend_port
      backend_port  = var.backend_port
    }
  )
}

# Executa o script completo de configuração da VM Data
resource "azurerm_virtual_machine_run_command" "configure_data_cin" {
  # Nome do Run Command criado dentro da VM Data
  name = "configure-windows-data"

  # Região da VM Data
  location = azurerm_windows_virtual_machine.vm_data_cin.location

  # VM que receberá o comando
  virtual_machine_id = azurerm_windows_virtual_machine.vm_data_cin.id

  # Envia o PowerShell como conteúdo de script, sem colocá-lo na linha de comando
  source {
    script = local.configure_data_cin_script
  }

  # Aguarda a configuração da extensão de gerenciamento do SQL Server
  depends_on = [
    azurerm_mssql_virtual_machine.sql_vm_data_cin
  ]

  # Permite que instalação, download e importação do BACPAC levem até 90 minutos
  timeouts {
    create = "90m"
    update = "90m"
    delete = "30m"
  }
}

# Executa o script completo de configuração da VM Backend
resource "azurerm_virtual_machine_run_command" "configure_bend_cus" {
  # Nome do Run Command criado dentro da VM Backend
  name = "configure-windows-bend"

  # Região da VM Backend
  location = azurerm_windows_virtual_machine.vm_bend_cus.location

  # VM que receberá o comando
  virtual_machine_id = azurerm_windows_virtual_machine.vm_bend_cus.id

  # Envia o PowerShell como conteúdo de script, sem colocá-lo na linha de comando
  source {
    script = local.configure_bend_cus_script
  }

  # O backend só será configurado depois que o banco estiver importado e validado
  depends_on = [
    azurerm_virtual_machine_run_command.configure_data_cin
  ]

  # Permite tempo suficiente para instalar IIS, Node.js e os demais componentes
  timeouts {
    create = "90m"
    update = "90m"
    delete = "30m"
  }
}

# Executa o script completo de configuração da VM Frontend
resource "azurerm_virtual_machine_run_command" "configure_fend_cus" {
  # Nome do Run Command criado dentro da VM Frontend
  name = "configure-windows-fend"

  # Região da VM Frontend
  location = azurerm_windows_virtual_machine.vm_fend_cus.location

  # VM que receberá o comando
  virtual_machine_id = azurerm_windows_virtual_machine.vm_fend_cus.id

  # Envia o PowerShell como conteúdo de script, sem colocá-lo na linha de comando
  source {
    script = local.configure_fend_cus_script
  }

  # O frontend só será configurado depois que o backend estiver funcionando
  depends_on = [
    azurerm_virtual_machine_run_command.configure_bend_cus
  ]

  # Permite tempo suficiente para instalar IIS, ARR e configurar o certificado
  timeouts {
    create = "90m"
    update = "90m"
    delete = "30m"
  }
}