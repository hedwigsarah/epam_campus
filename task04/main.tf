# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    Creator = var.creator_tag
  }
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = var.vnet_address_space
  tags = {
    Creator = var.creator_tag
  }
}

# Subnet (standalone resource)
resource "azurerm_subnet" "frontend" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_prefix]
}

# Public IP
resource "azurerm_public_ip" "main" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = var.dns_name_label
  tags = {
    Creator = var.creator_tag
  }
}

# Network Security Group
resource "azurerm_network_security_group" "main" {
  name                = var.nsg_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags = {
    Creator = var.creator_tag
  }
}

# NSG Rule - Allow HTTP (standalone resource)
resource "azurerm_network_security_rule" "allow_http" {
  name                        = var.nsg_rule_http_name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}

# NSG Rule - Allow SSH (standalone resource)
resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = var.nsg_rule_ssh_name
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}

# Network Interface
resource "azurerm_network_interface" "main" {
  name                = var.nic_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags = {
    Creator = var.creator_tag
  }

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

# Network Interface Security Group Association (standalone resource)
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "main" {
  name                            = var.vm_name
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = var.vm_size
  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.main.id]
  tags = {
    Creator = var.creator_tag
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  # Provisioner to install Nginx
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type     = "ssh"
      user     = var.vm_admin_username
      password = var.vm_password
      host     = azurerm_public_ip.main.ip_address
    }
  }

  depends_on = [
    azurerm_network_interface_security_group_association.main
  ]
}