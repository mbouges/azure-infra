provider "azurerm" {
  features {}

  # Subscription ID is set via ARM_SUBSCRIPTION_ID environment variable
  # or can be hardcoded here if you prefer:
  # subscription_id = var.subscription_id
}

# Remote backend — stores state in Azure Storage
# Bootstrap this storage account manually before first `terraform init`:
#   az group create -n rg-tfstate-prod-cus-001 -l centralus
#   az storage account create -n sttfstateprodcus001 -g rg-tfstate-prod-cus-001 -l centralus --sku Standard_LRS
#   az storage container create -n tfstate --account-name sttfstateprodcus001
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-prod-cus-001"
    storage_account_name = "sttfstateprodcus001"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
