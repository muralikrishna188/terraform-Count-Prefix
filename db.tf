resource "azurerm_subnet" "azdbsubnet709" {
  name = "dbsubnet"
  resource_group_name = azurerm_resource_group.azrg709.name
  virtual_network_name = azurerm_virtual_network.azvnet709.name
  address_prefixes = ["10.60.3.0/24"]

  
}
resource "azurerm_public_ip" "azdbpublic709" {
  name = "azdbpublicip101"
  resource_group_name = azurerm_resource_group.azrg709.name
  location = azurerm_resource_group.azrg709.location
  allocation_method = "Static"
  
}
resource "azurerm_network_interface" "azdbnic709" {
  name = "azdbnic101"
  resource_group_name = azurerm_resource_group.azrg709.name
  location = azurerm_resource_group.azrg709.location
  ip_configuration {
    name = "dbipocnfig"
    subnet_id = azurerm_subnet.azdbsubnet709.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.azdbpublic709.id
  }
  
}
resource "azurerm_linux_virtual_machine" "azdbvm709" {
  name = "azdbserver101"
  resource_group_name = azurerm_resource_group.azrg709.name
  location = azurerm_resource_group.azrg709.location
  size = "Standard_F2"
  admin_username = "adminuser"
  network_interface_ids = [ azurerm_network_interface.azdbnic709.id, ]
  admin_ssh_key {
    username = "adminuser"
    public_key = file("~/.ssh/id_ed25519.pub")
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }
}
