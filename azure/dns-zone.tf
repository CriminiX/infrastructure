resource "azurerm_dns_zone" "dns_criminix" {
    name                = "criminix.live"
    resource_group_name = azurerm_resource_group.rg_prod.name
}

resource "azurerm_dns_a_record" "criminix_live" {
    name                = "@"
    zone_name           = azurerm_dns_zone.dns_criminix.name
    resource_group_name = azurerm_resource_group.rg_prod.name
    ttl                 = 120
    records             = [ azurerm_public_ip.ip_public_vm-applications.ip_address ]
}
resource "azurerm_dns_a_record" "criminix_api" {
    name                = "api"
    zone_name           = azurerm_dns_zone.dns_criminix.name
    resource_group_name = azurerm_resource_group.rg_prod.name
    ttl                 = 120
    records             = [ azurerm_public_ip.ip_public_vm-applications.ip_address ]
}