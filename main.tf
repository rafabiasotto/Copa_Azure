# Resource group da região Central US
resource "azurerm_resource_group" "rg_cus" {
  name     = var.rg_name_cus
  location = var.rg_location_cus
}

module "module_network" {
  source = "./module_network"

  rg_name_cus        = azurerm_resource_group.rg_cus.name
  rg_location_cus    = azurerm_resource_group.rg_cus.location
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

  rg_name_cus              = azurerm_resource_group.rg_cus.name
  rg_location_cus          = azurerm_resource_group.rg_cus.location
  snet_fend_cus_id         = module.module_network.snet_fend_cus_id
  vm_name_fend_cus         = var.vm_name_fend_cus
  admin_username           = var.admin_username
  admin_password           = var.admin_password
  snet_bend_cus_id         = module.module_network.snet_bend_cus_id
  vm_name_bend_cus         = var.vm_name_bend_cus
  snet_data_cin_id         = module.module_network.snet_data_cin_id
  vm_name_data_cin         = var.vm_name_data_cin
  rg_location_cin          = var.location_cin
  sql_admin_username       = var.sql_admin_username
  sql_admin_password       = var.sql_admin_password
  backend_zip_url          = var.backend_zip_url
  node_major_version       = var.node_major_version
  iisnode_msi_url          = var.iisnode_msi_url
  url_rewrite_msi_url      = var.url_rewrite_msi_url
  backend_site_name        = var.backend_site_name
  backend_app_pool_name    = var.backend_app_pool_name
  backend_app_path         = var.backend_app_path
  backend_database_name    = var.backend_database_name
  backend_host             = var.backend_host
  backend_port             = var.backend_port
  backend_jwt_secret       = var.backend_jwt_secret
  backend_jwt_expires_in   = var.backend_jwt_expires_in
  backend_frontend_url     = var.backend_frontend_url
  backend_healthcheck_path = var.backend_healthcheck_path
  # URL do pacote compilado da aplicação frontend
  frontend_zip_url = var.frontend_zip_url

  # URLs dos instaladores necessários para o ARR
  external_cache_msi_url = var.external_cache_msi_url
  arr_msi_url            = var.arr_msi_url

  # Configurações do site e Application Pool do frontend
  frontend_site_name     = var.frontend_site_name
  frontend_app_pool_name = var.frontend_app_pool_name
  frontend_app_path      = var.frontend_app_path
  frontend_port          = var.frontend_port

  # Configuração dinâmica do endereço privado do backend
  frontend_backend_placeholder = var.frontend_backend_placeholder

  # Endpoints utilizados nos testes da aplicação
  frontend_healthcheck_path       = var.frontend_healthcheck_path
  frontend_proxy_healthcheck_path = var.frontend_proxy_healthcheck_path

  # URL do BACPAC utilizado para restaurar o banco na VM Data
  data_bacpac_url = var.data_bacpac_url

  # URL do SqlPackage utilizado para importar o BACPAC
  sqlpackage_zip_url = var.sqlpackage_zip_url

  # Quantidades esperadas para validar a importação do banco
  data_expected_matches_count  = var.data_expected_matches_count
  data_expected_stadiums_count = var.data_expected_stadiums_count
  data_expected_teams_count    = var.data_expected_teams_count

  # Habilita a configuração HTTPS no frontend
  frontend_https_enabled = true

  # Certificado PFX gerado pelo ACME
  frontend_certificate_pfx_base64 = acme_certificate.tickets.certificate_p12

  # Senha do PFX
  frontend_certificate_pfx_password = var.certificate_pfx_password

  # Hostname usado no binding HTTPS do IIS
  frontend_certificate_hostname = local.certificate_iis_hostname

  # Endpoint usado para teste HTTPS
  frontend_https_healthcheck_path = "/"
}

# Permite acesso RDP às VMs frontend e backend em Central US
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

# Permite acesso HTTPS à VM frontend em Central US
resource "azurerm_network_security_rule" "allow_https_fend_cus" {
  name                        = "Allow_HTTPS"
  priority                    = 310
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = module.module_vm.vm_private_ip_fend_cus
  resource_group_name         = azurerm_resource_group.rg_cus.name
  network_security_group_name = module.module_network.nsg_cus_name
}

# Permite acesso RDP à VM data em Central India
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

# Cria a zona DNS pública e o registro tickets no Resource Group existente
module "module_dns" {
  source = "./module_dns"

  rg_name_cus        = azurerm_resource_group.rg_cus.name
  dns_zone_name      = var.dns_zone_name
  frontend_public_ip = module.module_vm.vm_public_ip_fend_cus
}