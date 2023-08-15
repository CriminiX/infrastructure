data "azurerm_ssh_public_key" "key_prod" {
    name                = "key-criminix-prod"
    resource_group_name = azurerm_resource_group.rg_prod.name
}

resource "azurerm_network_interface" "nic_vm_applications" {
    name                = "nic-vm-applications"
    location            = azurerm_resource_group.rg_prod.location
    resource_group_name = azurerm_resource_group.rg_prod.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.snet_public.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.ip_public_vm-applications.id
    }

    depends_on = [ azurerm_public_ip.ip_public_vm-applications ]
}


resource "azurerm_public_ip" "ip_public_vm-applications" {
    name                = "ip-public-vm-applications"
    location            = azurerm_resource_group.rg_prod.location
    resource_group_name = azurerm_resource_group.rg_prod.name
    allocation_method   = "Static"
}


resource "azurerm_linux_virtual_machine" "vm_applications_prod" {
    name                  = "vm-applications-prod"
    location              = azurerm_resource_group.rg_prod.location
    resource_group_name   = azurerm_resource_group.rg_prod.name
    network_interface_ids = [ azurerm_network_interface.nic_vm_applications.id ]
    size                  = "Standard_B2ms"

    admin_username = "admincriminix"
    disable_password_authentication = true

    admin_ssh_key {
        username   = "admincriminix"
        public_key = data.azurerm_ssh_public_key.key_prod.public_key
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts"
        version   = "latest"
    }
    
    tags = {
        environment = "prod"
    }

    depends_on = [ azurerm_virtual_network.vnet_prod, azurerm_subnet.snet_public, azurerm_network_interface.nic_vm_applications ]
}