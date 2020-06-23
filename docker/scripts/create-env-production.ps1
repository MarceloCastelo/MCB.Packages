Write-Output "set variables for production environment"

$environment_name = "production"
$ip_second_octect = 21
$environment_port_prefix = 9
$docker_volume = "C:\docker\volumes"

.\create-env-base.ps1
