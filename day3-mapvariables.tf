##first lets disable the windows instance and win power 
  /* and at the end */
  #then create a file instance-map.tf paste from line 4 till 12
  variable "vm_instance_size" {
  description = "size of instance according to env"
  type = map(string)
  default = {
    "testing" = "Standard_B1s" #1 core processor 1 gb ram
    "development" = "Standard_F2" #2 core processor and 2 GB RAM
    "production" = "Standard_D2s_v3" #2 core with 8 GB RAM
  }
}
###then go to the vm.tf which contains your linux instance delete everything paste this 
  
resource "azurerm_linux_virtual_machine" "web_vm" {
  name                = "${local.name_prefix}-vm"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  size                = var.vm_instance_size["testing"]
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic.id, #public ip private ip and nsg
  ]
  #admin_password = "Admin@12345678"
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
    #it is an meta argument in terraform which will look for this file in the current directory  
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app/app.sh")
}

  

  
