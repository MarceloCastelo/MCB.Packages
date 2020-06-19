Write-Output "set variables for production environment"

$environment = "production"
$network_name = "production"
$network_ip_part = 21

.\up-env-base.ps1


