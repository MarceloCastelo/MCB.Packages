Write-Output "set variables for stagging environment"

$environment_name = "stagging"
$ip_second_octect = 20
$environment_port_prefix = 8
$docker_volume = "C:\docker\volumes"

.\create-env-base.ps1
