resource "azurerm_subnet" "azwebsubnet709" {
  name = "websubnet"
  resource_group_name = azurerm_resource_group.azrg709.name
  virtual_network_name = azurerm_virtual_network.azvnet709.name
  address_prefixes = ["10.60.1.0/24"]

  
}
resource "azurerm_public_ip" "azwebpublic709" {
  count = var.vm_count
  name = "${var.vm_name_pfx}-${count.index}-ip"
  resource_group_name = azurerm_resource_group.azrg709.name
  location = azurerm_resource_group.azrg709.location
  allocation_method = "Static"
  
}
resource "azurerm_network_interface" "azwebnic709" {
  count = var.vm_count
  name = "${var.vm_name_pfx}-${count.index}-nic"
  resource_group_name = azurerm_resource_group.azrg709.name
  location = azurerm_resource_group.azrg709.location
  ip_configuration {
    name = "ipocnfig"
    subnet_id = azurerm_subnet.azwebsubnet709.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.azwebpublic709[count.index].id
  }
  
}
resource "azurerm_linux_virtual_machine" "azwebvm709" {
  count = var.vm_count
  name = "${var.vm_name_pfx}-${count.index}"
  resource_group_name = azurerm_resource_group.azrg709.name
  location = azurerm_resource_group.azrg709.location
  size = "Standard_F2"
  admin_username = "adminuser"
  network_interface_ids = [ azurerm_network_interface.azwebnic709[count.index].id, ]
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