resource "azurerm_resource_group" "compute" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# --- Public IP ---

resource "azurerm_public_ip" "this" {
  name                = var.pip_name
  location            = azurerm_resource_group.compute.location
  resource_group_name = azurerm_resource_group.compute.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# --- Network Interface ---

resource "azurerm_network_interface" "this" {
  name                = var.nic_name
  location            = azurerm_resource_group.compute.location
  resource_group_name = azurerm_resource_group.compute.name
  tags                = var.tags

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

# --- Windows 11 Virtual Machine ---

resource "azurerm_windows_virtual_machine" "this" {
  name                = var.vm_name
  location            = azurerm_resource_group.compute.location
  resource_group_name = azurerm_resource_group.compute.name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  license_type        = "Windows_Client"
  tags                = var.tags

  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  os_disk {
    name                 = var.os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 128
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-23h2-pro"
    version   = "latest"
  }

  boot_diagnostics {}
}

# --- Auto-Shutdown ---

resource "azurerm_dev_test_global_vm_shutdown_schedule" "this" {
  virtual_machine_id    = azurerm_windows_virtual_machine.this.id
  location              = azurerm_resource_group.compute.location
  enabled               = true
  daily_recurrence_time = var.auto_shutdown_time
  timezone              = var.auto_shutdown_timezone

  notification_settings {
    enabled = false
  }

  tags = var.tags
}
