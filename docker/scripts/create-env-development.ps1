Write-Output "set variables for development environment"

$environment_name = "development"
$ip_second_octect = 18
$environment_port_prefix = 6
$docker_volume = "C:\docker\volumes"

.\create-env-base.ps1
