#
# create network
#

Write-Output "create network"
docker network create --subnet=172.${ip_second_octect}.0.0/16 ${environment_name}

#
# create docker volume
#

Write-Output "create docker volume"
$docker_volume = "C:\docker\volumes"
Write-Output "create volume directories"
$docker_volume_path = Join-Path -Path "${docker_volume}" -ChildPath "${environment_name}"
New-Item -ItemType Directory -Force -Path "$docker_volume_path"

#
# copy compose file
#

#Write-Output "copy compose file"
#Copy-Item ".\docker-compose.yml" -Destination "..\environments\${environment_name}"

#
# set variables
#

Write-Output "set variables"

Set-Location ..\environments\${environment_name}

.\set-env-base-variables.ps1
docker-compose.exe up -d

Set-Location ..\..\scripts | Write-Output
