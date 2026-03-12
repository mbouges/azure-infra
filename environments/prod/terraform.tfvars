location    = "centralus"
environment = "prod"

# IMPORTANT: Set your public IP here for RDP access
# Find your IP: https://ifconfig.me
allowed_rdp_source_ip = "REPLACE_WITH_YOUR_IP/32"

# VM admin credentials
# For security, set these via environment variables instead of this file:
#   export TF_VAR_vm_admin_password="YourSecurePassword123!"
vm_admin_username = "azureadmin"

# Auto-shutdown at 7 PM Central Time
auto_shutdown_time = "1900"
