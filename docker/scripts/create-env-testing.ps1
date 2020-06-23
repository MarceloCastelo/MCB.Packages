Write-Output "set variables for testing environment"

$environment_name = "testing"
$ip_second_octect = 19
$environment_port_prefix = 7
$docker_volume = "C:\docker\volumes"

.\create-env-base.ps1
