output "vm_name" {
  description = "Name of the Windows 11 VM"
  value       = module.compute.vm_name
}

output "vm_public_ip" {
  description = "Public IP address of the VM (use for RDP)"
  value       = module.compute.public_ip_address
}

output "vm_private_ip" {
  description = "Private IP address of the VM"
  value       = module.compute.private_ip_address
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.network.vnet_name
}

output "network_resource_group" {
  description = "Name of the networking resource group"
  value       = module.network.resource_group_name
}

output "compute_resource_group" {
  description = "Name of the compute resource group"
  value       = module.compute.resource_group_name
}
