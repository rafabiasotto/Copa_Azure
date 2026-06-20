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