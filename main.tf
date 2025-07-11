terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.27.0"
    }
  }
}
provider "azurerm" {
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id

  
}
resource "azurerm_resource_group" "azrg709" {
    name = "myapprg7899"
    location = "East US"
    tags = {
      "key" = "myrg105"
    }
  
}
resource "azurerm_virtual_network" "azvnet709" {
  name = "azvnet709"
  resource_group_name = azurerm_resource_group.azrg709.name
  location = azurerm_resource_group.azrg709.location
  address_space = ["10.60.0.0/16"]

  
}



resource "azurerm_subnet" "azmgmtsubnet709" {
  name = "mgmtsubnet"
  resource_group_name = azurerm_resource_group.azrg709.name
  virtual_network_name = azurerm_virtual_network.azvnet709.name
  address_prefixes = ["10.60.4.0/24"]

  
}

