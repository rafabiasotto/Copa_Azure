variable "rg_name_cus" {
  description = "Nome do Resource Group em Central US"
  type        = string
}

variable "rg_location_cus" {
  description = "Localização do Resource Group em Central US"
  type        = string
}

variable "rg_location_cin" {
  description = "Localização do Resource Group em Central India"
  type        = string
}

variable "snet_fend_cus_id" {
  description = "ID da subnet frontend em Central US"
  type        = string
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

variable "snet_bend_cus_id" {
  description = "ID da subnet backend em Central US"
  type        = string
}

variable "vm_name_bend_cus" {
  description = "Nome da VM backend"
  type        = string
}

variable "snet_data_cin_id" {
  description = "ID da subnet data em Central India"
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

# Habilita ou desabilita a configuração HTTPS no site frontend
variable "frontend_https_enabled" {
  description = "Define se o Custom Script da VM frontend deve configurar o binding HTTPS"
  type        = bool
}

# Certificado PFX em Base64 recebido do provider ACME
variable "frontend_certificate_pfx_base64" {
  description = "Certificado PFX em Base64 utilizado para configurar o HTTPS no IIS da VM frontend"
  type        = string
  sensitive   = true
}

# Senha do certificado PFX usado no IIS
variable "frontend_certificate_pfx_password" {
  description = "Senha do certificado PFX usado para importar o certificado no Windows"
  type        = string
  sensitive   = true
}

# Hostname configurado no binding HTTPS do IIS
variable "frontend_certificate_hostname" {
  description = "Hostname configurado no binding HTTPS do IIS da VM frontend"
  type        = string
}

# Caminho utilizado para teste HTTPS após configurar o certificado
variable "frontend_https_healthcheck_path" {
  description = "Caminho utilizado para validar o HTTPS localmente após configurar o certificado"
  type        = string
}