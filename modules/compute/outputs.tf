output "resource_group_name" {
  description = "Name of the compute resource group"
  value       = azurerm_resource_group.compute.name
}

output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_windows_virtual_machine.this.id
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_windows_virtual_machine.this.name
}

output "public_ip_address" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.this.ip_address
}

output "private_ip_address" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.this.private_ip_address
}
