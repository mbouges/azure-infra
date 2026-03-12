output "resource_group" {
  description = "Resource group name"
  value       = "rg-${local.suffix}"
}

output "virtual_network" {
  description = "Virtual network name"
  value       = "vnet-${local.suffix}"
}

output "subnet" {
  description = "Subnet name prefix — append a purpose suffix (e.g., -default, -bastion)"
  value       = "snet-${local.suffix}"
}

output "network_security_group" {
  description = "Network security group name"
  value       = "nsg-${local.suffix}"
}

output "public_ip" {
  description = "Public IP name"
  value       = "pip-${local.suffix}"
}

output "network_interface" {
  description = "Network interface name"
  value       = "nic-${local.suffix}"
}

output "virtual_machine" {
  description = "Virtual machine name (max 15 chars for Windows)"
  value       = "vm-${local.suffix}"
}

output "os_disk" {
  description = "OS disk name"
  value       = "osdisk-${local.suffix}"
}

output "key_vault" {
  description = "Key vault name (max 24 chars)"
  value       = "kv-${local.suffix}"
}

output "storage_account" {
  description = "Storage account name (no hyphens, max 24 chars)"
  value       = "st${local.suffix_clean}"
}

output "log_analytics_workspace" {
  description = "Log analytics workspace name"
  value       = "log-${local.suffix}"
}

output "suffix" {
  description = "The raw suffix for custom resource naming"
  value       = local.suffix
}

output "suffix_clean" {
  description = "The raw suffix without hyphens for resources that don't allow them"
  value       = local.suffix_clean
}

output "region_short" {
  description = "Abbreviated region code"
  value       = local.region_short
}
