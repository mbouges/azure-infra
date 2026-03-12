# --- Common Variables ---

variable "location" {
  description = "Primary Azure region"
  type        = string
  default     = "centralus"
}

variable "environment" {
  description = "Environment name (prod, dev, test)"
  type        = string
  default     = "prod"
}

# --- Network Variables ---

variable "allowed_rdp_source_ip" {
  description = "Your public IP address for RDP access (CIDR, e.g., 203.0.113.50/32)"
  type        = string
}

# --- Compute Variables ---

variable "vm_admin_username" {
  description = "Admin username for the Windows VM"
  type        = string
}

variable "vm_admin_password" {
  description = "Admin password for the Windows VM"
  type        = string
  sensitive   = true
}

variable "auto_shutdown_time" {
  description = "Auto-shutdown time in HHmm format (24hr, local timezone)"
  type        = string
  default     = "1900"
}
