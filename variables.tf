# ============================================================
# RESOURCE GROUP
# ============================================================

# Nome do Resource Group em Central US
variable "rg_name_cus" {
  description = "Nome do Resource Group localizado em Central US"
  type        = string
}

# Região do Resource Group principal
variable "rg_location_cus" {
  description = "Região do Resource Group localizado em Central US"
  type        = string
}


# ============================================================
# REDE — CENTRAL US
# ============================================================

# Nome do Network Security Group de Central US
variable "nsg_name_cus" {
  description = "Nome do NSG da VNet Central US"
  type        = string
}

# Nome da Virtual Network de Central US
variable "vnet_name_cus" {
  description = "Nome da VNet Central US"
  type        = string
}

# Espaço de endereçamento da Virtual Network de Central US
variable "vnet_cidr_cus" {
  description = "CIDR da VNet Central US"
  type        = list(string)
}

# Nome da subnet utilizada pela VM Frontend
variable "snet_name_fend_cus" {
  description = "Nome da subnet frontend em Central US"
  type        = string
}

# Espaço de endereçamento da subnet Frontend
variable "snet_cidr_fend_cus" {
  description = "CIDR da subnet frontend em Central US"
  type        = list(string)
}

# Nome da subnet utilizada pela VM Backend
variable "snet_name_bend_cus" {
  description = "Nome da subnet backend em Central US"
  type        = string
}

# Espaço de endereçamento da subnet Backend
variable "snet_cidr_bend_cus" {
  description = "CIDR da subnet backend em Central US"
  type        = list(string)
}


# ============================================================
# REDE — CENTRAL INDIA
# ============================================================

# Região utilizada pelos recursos em Central India
variable "location_cin" {
  description = "Localização dos recursos de rede em Central India"
  type        = string
}

# Nome do Network Security Group de Central India
variable "nsg_name_cin" {
  description = "Nome do NSG da VNet Central India"
  type        = string
}

# Nome da Virtual Network de Central India
variable "vnet_name_cin" {
  description = "Nome da VNet Central India"
  type        = string
}

# Espaço de endereçamento da Virtual Network de Central India
variable "vnet_cidr_cin" {
  description = "CIDR da VNet Central India"
  type        = list(string)
}

# Nome da subnet utilizada pela VM Data
variable "snet_name_data_cin" {
  description = "Nome da subnet data em Central India"
  type        = string
}

# Espaço de endereçamento da subnet Data
variable "snet_cidr_data_cin" {
  description = "CIDR da subnet data em Central India"
  type        = list(string)
}


# ============================================================
# MÁQUINAS VIRTUAIS
# ============================================================

# Nome da VM Frontend
variable "vm_name_fend_cus" {
  description = "Nome da VM frontend"
  type        = string
}

# Nome da VM Backend
variable "vm_name_bend_cus" {
  description = "Nome da VM backend"
  type        = string
}

# Nome da VM Data
variable "vm_name_data_cin" {
  description = "Nome da VM data"
  type        = string
}

# Usuário administrativo das máquinas virtuais
variable "admin_username" {
  description = "Usuário administrador das máquinas virtuais"
  type        = string
}

# Senha administrativa das máquinas virtuais
variable "admin_password" {
  description = "Senha do usuário administrador das máquinas virtuais"
  type        = string
  sensitive   = true
}


# ============================================================
# SQL SERVER
# ============================================================

# Usuário administrativo da autenticação SQL
variable "sql_admin_username" {
  description = "Usuário administrador da autenticação SQL Server"
  type        = string
}

# Senha administrativa da autenticação SQL
variable "sql_admin_password" {
  description = "Senha do usuário administrador da autenticação SQL Server"
  type        = string
  sensitive   = true
}


# ============================================================
# AZURE DNS
# ============================================================

# Nome da zona DNS pública
variable "dns_zone_name" {
  description = "Nome da zona DNS pública"
  type        = string
}


# ============================================================
# APLICAÇÃO BACKEND
# ============================================================

# URL do pacote ZIP da aplicação Backend
variable "backend_zip_url" {
  description = "URL do arquivo ZIP da aplicação backend"
  type        = string
}

# Versão principal do Node.js
variable "node_major_version" {
  description = "Versão major do Node.js LTS usada no backend"
  type        = number
}

# URL do instalador do iisnode
variable "iisnode_msi_url" {
  description = "URL do instalador MSI x64 do iisnode"
  type        = string
}

# URL do instalador do IIS URL Rewrite
variable "url_rewrite_msi_url" {
  description = "URL do instalador MSI x64 do IIS URL Rewrite"
  type        = string
}

# Nome do site Backend no IIS
variable "backend_site_name" {
  description = "Nome do site backend no IIS"
  type        = string
}

# Nome do Application Pool do Backend
variable "backend_app_pool_name" {
  description = "Nome do Application Pool do backend"
  type        = string
}

# Diretório de publicação do Backend
variable "backend_app_path" {
  description = "Diretório da aplicação backend na VM"
  type        = string
}

# Nome do banco utilizado pelo Backend
variable "backend_database_name" {
  description = "Nome do banco de dados utilizado pelo backend"
  type        = string
}

# Endereço em que a aplicação Node.js escutará
variable "backend_host" {
  description = "Endereço no qual a aplicação Node.js escutará"
  type        = string
}

# Porta utilizada pela aplicação Backend
variable "backend_port" {
  description = "Porta utilizada pela aplicação backend"
  type        = number
}

# Segredo utilizado para assinatura dos tokens JWT
variable "backend_jwt_secret" {
  description = "Segredo utilizado para assinatura dos tokens JWT"
  type        = string
  sensitive   = true
}

# Tempo de validade dos tokens JWT
variable "backend_jwt_expires_in" {
  description = "Tempo de validade dos tokens JWT"
  type        = string
}

# Origem permitida pelo CORS da aplicação
variable "backend_frontend_url" {
  description = "Origem permitida pelo CORS da aplicação backend"
  type        = string
}

# Endpoint de health check da API
variable "backend_healthcheck_path" {
  description = "Caminho do endpoint de health check do backend"
  type        = string
}


# ============================================================
# APLICAÇÃO FRONTEND
# ============================================================

# URL do pacote ZIP compilado da aplicação Frontend
variable "frontend_zip_url" {
  description = "URL do arquivo ZIP compilado da aplicação frontend"
  type        = string
}

# URL do instalador do IIS External Cache
variable "external_cache_msi_url" {
  description = "URL do instalador MSI x64 do IIS External Cache utilizado pelo ARR"
  type        = string
}

# URL do instalador do Application Request Routing
variable "arr_msi_url" {
  description = "URL do instalador MSI x64 do Application Request Routing"
  type        = string
}

# Nome do site Frontend no IIS
variable "frontend_site_name" {
  description = "Nome do site frontend criado no IIS"
  type        = string
}

# Nome do Application Pool do Frontend
variable "frontend_app_pool_name" {
  description = "Nome do Application Pool utilizado pelo site frontend"
  type        = string
}

# Diretório de publicação do Frontend
variable "frontend_app_path" {
  description = "Diretório onde os arquivos da aplicação frontend serão publicados"
  type        = string
}

# Porta HTTP utilizada pelo Frontend
variable "frontend_port" {
  description = "Porta HTTP utilizada pelo site frontend no IIS"
  type        = number
}

# Placeholder do endereço do Backend no web.config
variable "frontend_backend_placeholder" {
  description = "Placeholder do web.config que será substituído pelo endereço privado do backend"
  type        = string
}

# Caminho utilizado para validar a página inicial
variable "frontend_healthcheck_path" {
  description = "Caminho HTTP utilizado para validar a página principal do frontend"
  type        = string
}

# Caminho utilizado para validar o proxy reverso
variable "frontend_proxy_healthcheck_path" {
  description = "Caminho HTTP utilizado para validar o proxy reverso até o backend"
  type        = string
}


# ============================================================
# BANCO DE DADOS E BACPAC
# ============================================================

# URL do arquivo BACPAC da aplicação
variable "data_bacpac_url" {
  description = "URL do arquivo BACPAC utilizado para restaurar o banco da aplicação na VM Data"
  type        = string
}

# URL do pacote ZIP standalone do SqlPackage
variable "sqlpackage_zip_url" {
  description = "URL do pacote ZIP standalone do SqlPackage utilizado para importar o BACPAC"
  type        = string
}

# Quantidade esperada de partidas no banco
variable "data_expected_matches_count" {
  description = "Quantidade esperada de registros na tabela matches após a importação do BACPAC"
  type        = number
}

# Quantidade esperada de estádios no banco
variable "data_expected_stadiums_count" {
  description = "Quantidade esperada de registros na tabela stadiums após a importação do BACPAC"
  type        = number
}

# Quantidade esperada de seleções no banco
variable "data_expected_teams_count" {
  description = "Quantidade esperada de registros na tabela teams após a importação do BACPAC"
  type        = number
}


# ============================================================
# ACME E LET'S ENCRYPT
# ============================================================

# URL do servidor ACME
variable "acme_server_url" {
  description = "URL do servidor ACME utilizado para emissão do certificado"
  type        = string
}

# E-mail utilizado para registrar a conta ACME
variable "acme_email" {
  description = "E-mail utilizado para registrar a conta ACME no Let's Encrypt"
  type        = string
}

# Método de autenticação utilizado no Azure DNS
variable "acme_azure_auth_method" {
  description = "Método de autenticação utilizado pelo ACME para acessar o Azure DNS"
  type        = string
}

# Tempo máximo de propagação do desafio DNS
variable "acme_dns_propagation_timeout" {
  description = "Tempo máximo em segundos para aguardar a propagação do TXT _acme-challenge"
  type        = number
}

# Intervalo entre as verificações de propagação DNS
variable "acme_dns_polling_interval" {
  description = "Intervalo em segundos entre as verificações de propagação DNS"
  type        = number
}

# TTL do registro TXT temporário
variable "acme_dns_ttl" {
  description = "TTL em segundos do registro TXT temporário criado pelo ACME"
  type        = number
}


# ============================================================
# KEY VAULT E CERTIFICADO HTTPS
# ============================================================

# Nome globalmente único do Key Vault
variable "key_vault_name" {
  description = "Nome globalmente único do Key Vault que armazenará o certificado"
  type        = string
}

# SKU utilizada pelo Key Vault
variable "key_vault_sku_name" {
  description = "SKU utilizada pelo Azure Key Vault"
  type        = string
}

# Retenção de soft delete do Key Vault
variable "key_vault_soft_delete_retention_days" {
  description = "Quantidade de dias de retenção do soft delete do Key Vault"
  type        = number
}

# Nome do certificado armazenado no Key Vault
variable "key_vault_certificate_name" {
  description = "Nome utilizado para armazenar o certificado no Azure Key Vault"
  type        = string
}

# Senha utilizada para proteger o certificado PFX
variable "certificate_pfx_password" {
  description = "Senha utilizada para proteger o certificado no formato PFX"
  type        = string
  sensitive   = true
}

# Quantidade mínima de dias restantes antes de uma nova emissão
variable "certificate_min_days_remaining" {
  description = "Quantidade mínima de dias restantes antes de o ACME solicitar outro certificado"
  type        = number
}

# Nome do registro DNS utilizado no binding HTTPS
variable "certificate_iis_record_name" {
  description = "Nome do registro DNS utilizado no binding HTTPS do IIS"
  type        = string
}