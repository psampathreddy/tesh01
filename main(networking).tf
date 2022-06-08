## create resource group

resource "azurerm_resource_group" "sam-rg1" {
    name                    = "${var.rgname}-${var.environmentname}"
    location                = var.location
    tags = {
        sampath             = "project01"
        environment         = "developnment"
    }  
}

## create virtual network

resource "azurerm_virtual_network" "sam-net1" {
    resource_group_name     = "azurerm_resource_group.sam-rg1.name"
    name                    = "${var.vnetname}-${var.environmentname}"
    location                = var.location
    address_space           = [ "10.0.0.1/16" ]
    tags = {
      sampath               = "project01"
      environment           = "developnment"
    }  
}

## create subnet with in network

resource "azurerm_subnet" "sam-subnet1" {
    resource_group_name    = "azure_resource_group.sam-rg1.name"
    virtual_network_name   = "azurerm_virtual_network.sam-net1.name"
    name                   = "${var.subnetname}"
    address_prefixes       = [ "10.0.1.1/24" ]    
}

## create public ip address

resource "azurerm_public_ip" "publicip" {
    resource_group_name   = "azurerm_resource_group.sam-rg1"
    name                  = "${var.publicipname}"
    location              = var.location
    allocation_method     = "Dynamic"  
}


## create bastion host for in network

resource "azurerm_bastion_host" "sam-bastion01" {
    resource_group_name     = "azurerm_resource_group.sam-rg1.name"
    name                    = "${var.bastionname}"
    location                = var.location
}

## create network security group and assign rules to rdp and assign to subnet

resource "azurerm_network_security_group" "nsg-01" {
    resource_group_name    = "azurerm_resource_group.sam-rg1.name"
    name                   = "${var.nsgname}"
    location               = var.location
    tags = {
      sampath               = "project01"
      environment           = "developnment"
    }  
    security_rule {
        name                       = "RDP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

## create nif card

resource "azurerm_network_interface" "nic-01" {
    resource_group_name            = "azurerm_resource_group.sam-rg1.name"
    name                           = "${var.nicname}"
    location                       = var.location
    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.sam-subnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.publicip.id
    }
    tags = {
      sampath               = "project01"
      environment           = "developnment"
    } 
  
}

# Connect the security group to the network interface

resource "azurerm_network_interface_security_group_association" "test" {
    network_interface_id      = azurerm_network_interface.nic-01.id
    network_security_group_id = azurerm_network_security_group.nsg-01.id
}