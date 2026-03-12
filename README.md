# Azure Infrastructure as Code

Personal Azure tenant infrastructure managed with Terraform. Follows Microsoft Cloud Adoption Framework naming conventions and is designed to be expanded incrementally.

## Architecture

- **Single subscription** with resource groups for isolation
- **Central US** region with a hub VNet (`10.0.0.0/16`)
- **Windows 11 VM** (`Standard_B2ms`) with Standard SSD, auto-shutdown, and RDP locked to a specific IP
- **GitHub Actions CI/CD** with OIDC authentication (no stored secrets)

## Project Structure

```
azure-infra/
├── .github/workflows/        # CI/CD — plan on PR, apply on merge
├── environments/prod/         # Root module for production
│   ├── main.tf                # Orchestrates child modules
│   ├── providers.tf           # AzureRM provider + remote backend
│   ├── variables.tf           # Input variables
│   ├── terraform.tfvars       # Variable values (no secrets!)
│   └── outputs.tf             # Useful outputs
└── modules/
    ├── naming/                # Naming convention helper
    ├── network/               # VNet, subnets, NSGs
    └── compute/               # VMs, NICs, public IPs
```

## Naming Convention

**Pattern**: `{type}-{workload}-{environment}-{region}-{instance}`

| Resource | Example |
|---|---|
| Resource Group | `rg-network-prod-cus-001` |
| Virtual Network | `vnet-network-prod-cus-001` |
| Virtual Machine | `vm-desktop-prod-cus-001` |
| Storage Account | `stcoreprodcus001` |

Region codes: `centralus` → `cus`, `eastus` → `eus`, `westus2` → `wus2`

## Prerequisites

1. **Azure CLI** installed and authenticated (`az login`)
2. **Terraform** >= 1.5 installed
3. An Azure subscription

## Bootstrap (One-Time Setup)

Before the first `terraform init`, create the remote state backend manually:

```bash
# Create resource group and storage account for Terraform state
az group create -n rg-tfstate-prod-cus-001 -l centralus
az storage account create -n sttfstateprodcus001 -g rg-tfstate-prod-cus-001 -l centralus --sku Standard_LRS
az storage container create -n tfstate --account-name sttfstateprodcus001
```

## Local Usage

```bash
cd environments/prod

# Set your VM admin password (never commit this)
export TF_VAR_vm_admin_password="YourSecurePassword123!"

# Initialize and plan
terraform init
terraform plan

# Apply when ready
terraform apply
```

**Important**: Update `allowed_rdp_source_ip` in `terraform.tfvars` with your public IP before applying.

## GitHub Actions Setup (OIDC)

1. Create an Azure AD App Registration and federated credential for GitHub Actions
2. Grant it **Contributor** on your subscription
3. Add these GitHub repo secrets:
   - `ARM_CLIENT_ID`
   - `ARM_TENANT_ID`
   - `ARM_SUBSCRIPTION_ID`
4. (Optional) Create a `production` environment in GitHub with required reviewers

## Expanding This Framework

**Add a new region:**
```hcl
# In environments/prod/main.tf — add another module call
module "naming_network_eus" {
  source      = "../../modules/naming"
  workload    = "network"
  environment = "prod"
  region      = "eastus"
}

module "network_eus" {
  source              = "../../modules/network"
  resource_group_name = module.naming_network_eus.resource_group
  location            = "eastus"
  # ... same pattern as centralus
}
```

**Add a dev environment:** Duplicate `environments/prod/` to `environments/dev/` with different `terraform.tfvars` and a separate state key.

**Add new resource types:** Create a new module under `modules/` (e.g., `modules/keyvault/`) and call it from `main.tf`.

## Estimated Cost

| Resource | Monthly Cost |
|---|---|
| VM Standard_B2ms (2-3 hrs/day) | ~$5-8 |
| Standard SSD 128 GB | ~$8 |
| Public IP (static) | ~$4 |
| Storage (tfstate) | ~$1 |
| **Total** | **~$18-21/mo** |
