## values that are changeble

## location 
variable "location" {
    type = string
    description = "location name"
    default = "eastus"  
}

## environmnet name
variable "environmentname" {
    type = string
    description = "developnment name"
    default = "dev"  
}


## resource group name
variable "rgname" {
    type = string
    description = "resource group name"
    default = "netrg"  
}

## virtual network name
variable "vnetname" {
    type = string
    description = "vnet name"
    default = "vnet"
}

## subnet name
variable "subnetname" {
    type = string
    description = "subnet name"
    default = "devsubnet"  
}


## public ip name
variable "publicipname" {
    type = string
    description = "public ip name"
    default = "publicipdev"  
}

## bastion host name
variable "bastionname" {
    type = string
    description = "bastion host name"
    default = "devbastion" 
}

## nsg name
variable "nsgname" {
    type = string
    description = "nsg name"
    default = "devnsg"  
}

## network_interface card
variable "nicname" {
    type = string
    description = "nic card name"
    default = "nicdev"  
}