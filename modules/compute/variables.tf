variable "resource_group_name" {
  description = "Name of the resource group for compute resources"
  type        = string
}

variable "location" {
  description = "Azure region for all compute resources"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B2ms"
}

variable "os_disk_name" {
  description = "Name of the OS disk"
  type        = string
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "pip_name" {
  description = "Name of the public IP address"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to attach the NIC to"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "auto_shutdown_time" {
  description = "Daily auto-shutdown time in HHmm format (24hr UTC). Set to empty string to disable."
  type        = string
  default     = "0000"
}

variable "auto_shutdown_timezone" {
  description = "Timezone for auto-shutdown (e.g., Central Standard Time)"
  type        = string
  default     = "Central Standard Time"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
