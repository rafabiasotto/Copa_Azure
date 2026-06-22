# Variáveis para o resource group Central US
variable "rg_name_cus" {
  description = "Nome do Resource Group localizado em Central US"
  type        = string
}

variable "rg_location_cus" {
  description = "Região do Resource Group localizado em Central US"
  type        = string
}

# Variáveis para o network Central US
variable "nsg_name_cus" {
  description = "Nome do NSG da VNet Central US"
  type        = string
}

variable "vnet_name_cus" {
  description = "Nome da VNet Central US"
  type        = string
}

variable "vnet_cidr_cus" {
  description = "CIDR da VNet Central US"
  type        = list(string)
}

variable "snet_name_fend_cus" {
  description = "Nome da subnet frontend em Central US"
  type        = string
}

variable "snet_cidr_fend_cus" {
  description = "CIDR da subnet frontend em Central US"
  type        = list(string)
}

variable "snet_name_bend_cus" {
  description = "Nome da subnet backend em Central US"
  type        = string
}

variable "snet_cidr_bend_cus" {
  description = "CIDR da subnet backend em Central US"
  type        = list(string)
}

# Localização dos recursos de rede em Central India
variable "location_cin" {
  description = "Localização dos recursos de rede em Central India"
  type        = string
}

# Variáveis para o network Central India
variable "nsg_name_cin" {
  description = "Nome do NSG da VNet Central India"
  type        = string
}

variable "vnet_name_cin" {
  description = "Nome da VNet Central India"
  type        = string
}

variable "vnet_cidr_cin" {
  description = "CIDR da VNet Central India"
  type        = list(string)
}

variable "snet_name_data_cin" {
  description = "Nome da subnet data em Central India"
  type        = string
}

variable "snet_cidr_data_cin" {
  description = "CIDR da subnet data em Central India"
  type        = list(string)
}

variable "vm_name_fend_cus" {
  description = "Nome da VM frontend"
  type        = string
}

variable "admin_username" {
  description = "Usuário da VM"
  type        = string
}

variable "admin_password" {
  description = "Senha da VM"
  type        = string
  sensitive   = true
}

variable "vm_name_bend_cus" {
  description = "Nome da VM backend"
  type        = string
}

variable "vm_name_data_cin" {
  description = "Nome da VM data"
  type        = string
}

variable "sql_admin_username" {
  description = "Usuário administrador da autenticação SQL Server"
  type        = string
}

variable "sql_admin_password" {
  description = "Senha do usuário administrador da autenticação SQL Server"
  type        = string
  sensitive   = true
}

# Nome da zona DNS pública
variable "dns_zone_name" {
  description = "Nome da zona DNS pública"
  type        = string
}

variable "backend_zip_url" {
  description = "URL do arquivo ZIP da aplicação backend"
  type        = string
}

variable "node_major_version" {
  description = "Versão major do Node.js LTS usada no backend"
  type        = number
}

variable "iisnode_msi_url" {
  description = "URL do instalador MSI x64 do iisnode"
  type        = string
}

variable "url_rewrite_msi_url" {
  description = "URL do instalador MSI x64 do IIS URL Rewrite"
  type        = string
}

variable "backend_site_name" {
  description = "Nome do site backend no IIS"
  type        = string
}

variable "backend_app_pool_name" {
  description = "Nome do Application Pool do backend"
  type        = string
}

variable "backend_app_path" {
  description = "Diretório da aplicação backend na VM"
  type        = string
}

variable "backend_database_name" {
  description = "Nome do banco de dados utilizado pelo backend"
  type        = string
}

variable "backend_host" {
  description = "Endereço no qual a aplicação Node.js escutará"
  type        = string
}

variable "backend_port" {
  description = "Porta utilizada pela aplicação backend"
  type        = number
}

variable "backend_jwt_secret" {
  description = "Segredo utilizado para assinatura dos tokens JWT"
  type        = string
  sensitive   = true
}

variable "backend_jwt_expires_in" {
  description = "Tempo de validade dos tokens JWT"
  type        = string
}

variable "backend_frontend_url" {
  description = "Origem permitida pelo CORS da aplicação backend"
  type        = string
}

variable "backend_healthcheck_path" {
  description = "Caminho do endpoint de health check do backend"
  type        = string
}

# URL do arquivo ZIP compilado da aplicação frontend
variable "frontend_zip_url" {
  description = "URL do arquivo ZIP compilado da aplicação frontend"
  type        = string
}

# URL do instalador MSI x64 do IIS External Cache
variable "external_cache_msi_url" {
  description = "URL do instalador MSI x64 do IIS External Cache utilizado pelo ARR"
  type        = string
}

# URL do instalador MSI x64 do Application Request Routing
variable "arr_msi_url" {
  description = "URL do instalador MSI x64 do Application Request Routing"
  type        = string
}

# Nome do site frontend criado no IIS
variable "frontend_site_name" {
  description = "Nome do site frontend criado no IIS"
  type        = string
}

# Nome do Application Pool utilizado pelo frontend
variable "frontend_app_pool_name" {
  description = "Nome do Application Pool utilizado pelo site frontend"
  type        = string
}

# Diretório de publicação da aplicação frontend
variable "frontend_app_path" {
  description = "Diretório onde os arquivos da aplicação frontend serão publicados"
  type        = string
}

# Porta utilizada pelo site frontend
variable "frontend_port" {
  description = "Porta HTTP utilizada pelo site frontend no IIS"
  type        = number
}

# Placeholder do endereço do backend no web.config
variable "frontend_backend_placeholder" {
  description = "Placeholder do web.config que será substituído pelo endereço privado do backend"
  type        = string
}

# Caminho usado para validar a página principal
variable "frontend_healthcheck_path" {
  description = "Caminho HTTP utilizado para validar a página principal do frontend"
  type        = string
}

# Caminho usado para validar o proxy reverso
variable "frontend_proxy_healthcheck_path" {
  description = "Caminho HTTP utilizado para validar o proxy reverso até o backend"
  type        = string
}

# URL do arquivo BACPAC utilizado para restaurar o banco da aplicação
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

# URL do servidor ACME usado para emissão do certificado Let's Encrypt
variable "acme_server_url" {
  description = "URL do servidor ACME utilizado para emissão do certificado"
  type        = string
}

# E-mail usado no registro da conta ACME do Let's Encrypt
variable "acme_email" {
  description = "E-mail usado no registro da conta ACME do Let's Encrypt"
  type        = string
}

# Método de autenticação usado pelo ACME/Lego para gerenciar o desafio DNS no Azure DNS
variable "acme_azure_auth_method" {
  description = "Método de autenticação usado pelo ACME para criar o TXT no Azure DNS"
  type        = string
}

# Tempo máximo de propagação DNS aguardado pelo desafio ACME
variable "acme_dns_propagation_timeout" {
  description = "Tempo máximo em segundos para aguardar propagação DNS do TXT _acme-challenge"
  type        = number
}

# Intervalo de checagem da propagação DNS durante o desafio ACME
variable "acme_dns_polling_interval" {
  description = "Intervalo em segundos entre as checagens de propagação DNS"
  type        = number
}

# TTL do registro TXT temporário criado pelo desafio ACME
variable "acme_dns_ttl" {
  description = "TTL em segundos do registro TXT temporário criado pelo desafio ACME"
  type        = number
}

# Nome do Key Vault criado no Resource Group atual
variable "key_vault_name" {
  description = "Nome globalmente único do Key Vault que armazenará o certificado"
  type        = string
}

# SKU do Key Vault
variable "key_vault_sku_name" {
  description = "SKU do Key Vault utilizado para armazenar o certificado"
  type        = string
}

# Retenção de soft delete do Key Vault
variable "key_vault_soft_delete_retention_days" {
  description = "Quantidade de dias de retenção do soft delete do Key Vault"
  type        = number
}

# Nome do certificado dentro do Key Vault
variable "key_vault_certificate_name" {
  description = "Nome do certificado importado no Key Vault"
  type        = string
}

# Senha do PFX gerado pelo ACME e importado no Key Vault/IIS
variable "certificate_pfx_password" {
  description = "Senha utilizada para proteger o certificado PFX"
  type        = string
  sensitive   = true
}

# Quantidade mínima de dias restantes antes de o provider ACME tentar renovar em novo apply
variable "certificate_min_days_remaining" {
  description = "Quantidade mínima de dias restantes antes de o provider ACME tentar renovar o certificado"
  type        = number
}

# Nome do registro usado como hostname HTTPS no IIS
variable "certificate_iis_record_name" {
  description = "Nome do registro DNS usado como hostname HTTPS no IIS"
  type        = string
}