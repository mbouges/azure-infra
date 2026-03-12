variable "resource_group_name" {
  description = "Name of the resource group for networking resources"
  type        = string
}

variable "location" {
  description = "Azure region for all networking resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Map of subnets to create. Key is the subnet name, value is the address prefix."
  type = map(object({
    address_prefix = string
  }))
  default = {
    default = {
      address_prefix = "10.0.1.0/24"
    }
  }
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "allowed_rdp_source_ip" {
  description = "Source IP address allowed to RDP into VMs (e.g., your home IP). Use a /32 CIDR."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
