# Variáveis para o resource group Central US
variable "rg_name_cus" {
  description = "Nome do Resource Group em Central US"
  type        = string
}

variable "rg_location_cus" {
  description = "Localização do Resource Group em Central US"
  type        = string
}

# Variáveis para o newtork Central US
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

# Variáveis para o newtork Central India
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