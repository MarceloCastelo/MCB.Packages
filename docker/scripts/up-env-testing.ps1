Write-Output "set variables for testing environment"

$environment_name = "testing"
$ip_second_octect = 19
$environment_port_prefix = 7

.\up-env-base.ps1

# stop all containers
docker ps -q | ForEach-Object { docker stop $_ }
