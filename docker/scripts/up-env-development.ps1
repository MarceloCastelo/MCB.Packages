Write-Output "set variables for development environment"

$environment_name = "development"
$ip_second_octect = 18
$environment_port_prefix = 6

.\up-env-base.ps1

# stop all containers
docker ps -q | ForEach-Object { docker stop $_ }
