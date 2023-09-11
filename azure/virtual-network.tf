resource "azurerm_virtual_network" "vnet_prod" {
    name                = "vnet-criminix-prod"
    location            = azurerm_resource_group.rg_prod.location
    resource_group_name = azurerm_resource_group.rg_prod.name
    address_space       = ["10.0.0.0/16"]

    tags = {
        "environment" = "prod"
    }
}

resource "azurerm_subnet" "snet_public" {
    name                 = "snet-public"
    resource_group_name  = azurerm_resource_group.rg_prod.name
    virtual_network_name = azurerm_virtual_network.vnet_prod.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg_prod" {
    name                = "nsg-prod"
    location            = azurerm_resource_group.rg_prod.location
    resource_group_name = azurerm_resource_group.rg_prod.name

    tags = {
        "environment" = "prod"
    }

    depends_on = [ azurerm_virtual_network.vnet_prod ]
}


resource "azurerm_network_security_rule" "allow_https" {
    name                       = "allow-https-port"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

    resource_group_name         = azurerm_resource_group.rg_prod.name
    network_security_group_name = azurerm_network_security_group.nsg_prod.name

    depends_on = [ azurerm_network_security_group.nsg_prod ]
}

resource "azurerm_network_security_rule" "allow_http" {
    name                       = "allow-http-port"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

    resource_group_name         = azurerm_resource_group.rg_prod.name
    network_security_group_name = azurerm_network_security_group.nsg_prod.name

    depends_on = [ azurerm_network_security_group.nsg_prod ]
}

# resource "azurerm_network_security_rule" "allow_api" {
#     name                       = "allow-api-port"
#     priority                   = 102
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "8080"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"

#     resource_group_name         = azurerm_resource_group.rg_prod.name
#     network_security_group_name = azurerm_network_security_group.nsg_prod.name

#     depends_on = [ azurerm_network_security_group.nsg_prod ]
# }

resource "azurerm_network_security_rule" "allow_ssh" {
    name                       = "allow-ssh-port"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

    resource_group_name         = azurerm_resource_group.rg_prod.name
    network_security_group_name = azurerm_network_security_group.nsg_prod.name

    depends_on = [ azurerm_network_security_group.nsg_prod ]
}

# resource "azurerm_network_security_rule" "allow_db" {
#     name                       = "allow-db-port"
#     priority                   = 104
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "3306"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"

#     resource_group_name         = azurerm_resource_group.rg_prod.name
#     network_security_group_name = azurerm_network_security_group.nsg_prod.name

#     depends_on = [ azurerm_network_security_group.nsg_prod ]
# }
