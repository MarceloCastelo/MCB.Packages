Write-Output "set variables for stagging environment"

$environment_name = "stagging"
$ip_second_octect = 20
$environment_port_prefix = 8

.\up-env-base.ps1

# stop all containers
docker ps -q | ForEach-Object { docker stop $_ }
