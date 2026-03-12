locals {
  # Region abbreviation lookup
  region_abbreviations = {
    centralus   = "cus"
    eastus      = "eus"
    eastus2     = "eus2"
    westus2     = "wus2"
    westus3     = "wus3"
    northeurope = "neu"
    westeurope  = "weu"
  }

  region_short = lookup(local.region_abbreviations, var.region, var.region)

  # Base suffix: {workload}-{environment}-{region_short}-{instance}
  suffix = "${var.workload}-${var.environment}-${local.region_short}-${var.instance}"

  # Storage accounts cannot have hyphens and must be lowercase, max 24 chars
  suffix_clean = "${var.workload}${var.environment}${local.region_short}${var.instance}"
}
