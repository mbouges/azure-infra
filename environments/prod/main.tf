# ============================================================================
# Root module — orchestrates all child modules for the prod environment
# ============================================================================

locals {
  tags = {
    environment = var.environment
    managed_by  = "terraform"
    repo        = "azure-infra"
  }
}

# --- Naming Conventions ---

module "naming_network" {
  source = "../../modules/naming"

  workload    = "network"
  environment = var.environment
  region      = var.location
}

module "naming_desktop" {
  source = "../../modules/naming"

  workload    = "desktop"
  environment = var.environment
  region      = var.location
}

# --- Networking ---

module "network" {
  source = "../../modules/network"

  resource_group_name = module.naming_network.resource_group
  location            = var.location
  vnet_name           = module.naming_network.virtual_network
  nsg_name            = module.naming_network.network_security_group

  vnet_address_space = ["10.0.0.0/16"]

  subnets = {
    "snet-default-${var.environment}-cus-001" = {
      address_prefix = "10.0.1.0/24"
    }
    # Reserved for future Azure Bastion
    # "AzureBastionSubnet" = {
    #   address_prefix = "10.0.255.0/26"
    # }
  }

  allowed_rdp_source_ip = var.allowed_rdp_source_ip

  tags = local.tags
}

# --- Compute (Windows 11 VM) ---

module "compute" {
  source = "../../modules/compute"

  resource_group_name = module.naming_desktop.resource_group
  location            = var.location
  vm_name             = module.naming_desktop.virtual_machine
  os_disk_name        = module.naming_desktop.os_disk
  nic_name            = module.naming_desktop.network_interface
  pip_name            = module.naming_desktop.public_ip
  subnet_id           = module.network.subnet_ids["snet-default-${var.environment}-cus-001"]

  vm_size        = "Standard_B2ms"
  admin_username = var.vm_admin_username
  admin_password = var.vm_admin_password

  auto_shutdown_time     = var.auto_shutdown_time
  auto_shutdown_timezone = "Central Standard Time"

  tags = local.tags
}
