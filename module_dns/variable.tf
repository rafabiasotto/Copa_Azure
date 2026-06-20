# Nome do Resource Group existente em Central US
variable "rg_name_cus" {
  description = "Nome do Resource Group existente em Central US"
  type        = string
}

# Nome da zona DNS pública
variable "dns_zone_name" {
  description = "Nome da zona DNS pública"
  type        = string
}

# IP público da VM frontend
variable "frontend_public_ip" {
  description = "IP público da VM frontend em Central US"
  type        = string
}