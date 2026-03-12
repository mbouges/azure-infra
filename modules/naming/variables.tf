variable "workload" {
  description = "Short name for the workload (e.g., hub, desktop, core)"
  type        = string
}

variable "environment" {
  description = "Environment abbreviation (e.g., prod, dev, test)"
  type        = string
}

variable "region" {
  description = "Azure region (e.g., centralus, eastus)"
  type        = string
}

variable "instance" {
  description = "Instance number for uniqueness (e.g., 001, 002)"
  type        = string
  default     = "001"
}
