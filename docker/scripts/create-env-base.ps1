Write-Output "create network"
docker network create --subnet=172.${ip_second_octect}.0.0/16 ${environment_name}

Write-Output "set variables"

$docker_volume = "C:\docker\volumes"

.\set-env-base-variables.ps1

Write-Output "create volume directories"
$docker_volume_path = Join-Path -Path "${docker_volume}" -ChildPath "${environment_name}"
New-Item -ItemType Directory -Force -Path "$docker_volume_path"


docker-compose.exe up -d

Set-Location ..\..\scripts | Write-Output
