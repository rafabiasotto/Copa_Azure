# Cria a zona DNS pública rafacloud.shop no Resource Group existente
resource "azurerm_dns_zone" "dns_zone" {
  name                = var.dns_zone_name
  resource_group_name = var.rg_name_cus
}

# Cria o registro A tickets apontando para o IP público da VM frontend
resource "azurerm_dns_a_record" "tickets" {
  name                = "tickets"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.rg_name_cus
  ttl                 = 3600

  records = [
    var.frontend_public_ip
  ]
}