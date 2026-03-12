output "resource_group_name" {
  description = "Name of the networking resource group"
  value       = azurerm_resource_group.network.name
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Map of subnet name to subnet ID"
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "nsg_id" {
  description = "ID of the network security group"
  value       = azurerm_network_security_group.this.id
}
