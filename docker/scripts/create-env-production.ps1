Write-Output "set variables for production environment"

$environment_name = "production"
$ip_second_octect = 21
$environment_port_prefix = 9

.\create-env-base.ps1
