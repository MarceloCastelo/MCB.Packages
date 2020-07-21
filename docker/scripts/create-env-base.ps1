#
# set variables
#

$postgresql_container_name="postgresql"
$mongodb_container_name="mongodb"
$ravendb_container_name="ravendb"
$prometheus_container_name="prometheus"

$rabbitmq_container_name="rabbitmq"

$pgadmin_container_name="pgadmin"
$mongoclient_container_name="mongoclient"
$grafana_container_name="grafana"
$sonarqube_container_name="sonarqube"

$docker_volume = "C:\docker\volumes"
$docker_volume_path = Join-Path -Path "${docker_volume}" -ChildPath "${environment_name}"
$docker_config = "C:\docker\configs"
$docker_config_path = Join-Path -Path "${docker_config}" -ChildPath "${environment_name}"
$docker_log = "C:\docker\log"
$docker_log_path = Join-Path -Path "${docker_log}" -ChildPath "${environment_name}"
$docker_extensions = "C:\docker\extensions"
$docker_extensions_path = Join-Path -Path "${docker_extensions}" -ChildPath "${environment_name}"

$docker_config_path_postgresql = Join-Path -Path "${docker_config_path}" -ChildPath "${postgresql_container_name}"
$docker_config_path_mongodb = Join-Path -Path "${docker_config_path}" -ChildPath "${mongodb_container_name}"
$docker_config_path_ravendb = Join-Path -Path "${docker_config_path}" -ChildPath "${ravendb_container_name}"
$docker_config_path_prometheus = Join-Path -Path "${docker_config_path}" -ChildPath "${prometheus_container_name}"

$docker_config_path_rabbitmq = Join-Path -Path "${docker_config_path}" -ChildPath "${rabbitmq_container_name}"

$docker_config_path_pgadmin = Join-Path -Path "${docker_config_path}" -ChildPath "${docker_config_path_pgadmin}"
$docker_config_path_mongoclient = Join-Path -Path "${docker_config_path}" -ChildPath "${docker_config_path_mongoclient}"
$docker_config_path_grafana = Join-Path -Path "${docker_config_path}" -ChildPath "${grafana_container_name}"
$docker_config_path_sonarqube = Join-Path -Path "${docker_config_path}" -ChildPath "${sonarqube_container_name}"

$docker_extensions_path_sonarqube = Join-Path -Path "${docker_extensions_path}" -ChildPath "${sonarqube_container_name}"


$env_filename="..\generated\environments\${environment_name}\.env"

#
# update .env file
#

Write-Output "update .env file"
if(Test-Path -path $env_filename) 
{ 
    Clear-Content $env_filename 
}
else 
{
    if (!(Test-Path -path "..\generated\environments\${environment_name}")) { New-Item -ItemType Directory -Force -Path "..\generated\environments\${environment_name}" }
}

Add-Content $env_filename "postgresql_container_name=${postgresql_container_name}"
Add-Content $env_filename "mongodb_container_name=${mongodb_container_name}"
Add-Content $env_filename "ravendb_container_name=${ravendb_container_name}"
Add-Content $env_filename "prometheus_container_name=${prometheus_container_name}"

Add-Content $env_filename "rabbitmq_container_name=${rabbitmq_container_name}"

Add-Content $env_filename "pgadmin_container_name=${pgadmin_container_name}"
Add-Content $env_filename "mongoclient_container_name=${mongoclient_container_name}"
Add-Content $env_filename "grafana_container_name=${grafana_container_name}"
Add-Content $env_filename "sonarqube_container_name=${sonarqube_container_name}"

Add-Content $env_filename "environment_name=${environment_name}"
Add-Content $env_filename "ip_second_octect=${ip_second_octect}"
Add-Content $env_filename "environment_port_prefix=${environment_port_prefix}"
Add-Content $env_filename "docker_volume=${docker_volume}"
Add-Content $env_filename "docker_config=${docker_config}"
Add-Content $env_filename "docker_log=${docker_log}"
Add-Content $env_filename "docker_extensions=${docker_extensions}"

Add-Content $env_filename "docker_config_path_postgresql=${docker_config_path_postgresql}"
Add-Content $env_filename "docker_config_path_mongodb=${docker_config_path_mongodb}"
Add-Content $env_filename "docker_config_path_ravendb=${docker_config_path_ravendb}"
Add-Content $env_filename "docker_config_path_prometheus=${docker_config_path_prometheus}"

Add-Content $env_filename "docker_config_path_rabbitmq=${docker_config_path_rabbitmq}"

Add-Content $env_filename "docker_config_path_pgadmin=${docker_config_path_pgadmin}"
Add-Content $env_filename "docker_config_path_mongoclient=${docker_config_path_mongoclient}"
Add-Content $env_filename "docker_config_path_grafana=${docker_config_path_grafana}"
Add-Content $env_filename "docker_config_path_sonarqube=${docker_config_path_sonarqube}"

Add-Content $env_filename "docker_extensions_path_sonarqube=${docker_extensions_path_sonarqube}"

#
# create config directories
#

Write-Output "create config directories"
if (!(Test-Path -path $docker_config_path_postgresql)) { New-Item -ItemType Directory -Force -Path "$docker_config_path_postgresql" }
if (!(Test-Path -path $docker_config_path_mongodb)) { New-Item -ItemType Directory -Force -Path "$docker_config_path_mongodb" }
if (!(Test-Path -path $docker_config_path_ravendb)) { New-Item -ItemType Directory -Force -Path "$docker_config_path_ravendb" }
if (!(Test-Path -path $docker_config_path_prometheus)) { New-Item -ItemType Directory -Force -Path "$docker_config_path_prometheus" }

if (!(Test-Path -path $docker_config_path_rabbitmq)) { New-Item -ItemType Directory -Force -Path "$docker_config_path_rabbitmq" }

if (!(Test-Path -path $pgadmin_container_name)) { New-Item -ItemType Directory -Force -Path "$pgadmin_container_name" }
if (!(Test-Path -path $mongoclient_container_name)) { New-Item -ItemType Directory -Force -Path "$mongoclient_container_name" }
if (!(Test-Path -path $grafana_container_name)) { New-Item -ItemType Directory -Force -Path "$grafana_container_name" }
if (!(Test-Path -path $sonarqube_container_name)) { New-Item -ItemType Directory -Force -Path "$sonarqube_container_name" }

#
# copy config files
#
Write-Output "copy config files"

$postgresql_config_file = "..\configs\${postgresql_container_name}"
if (Test-Path -path $postgresql_config_file) { Copy-Item "$postgresql_config_file\*" -Destination $docker_config_path_postgresql }

$mongodb_config_file = "..\configs\${mongodb_container_name}"
if (Test-Path -path $mongodb_config_file) { Copy-Item "$mongodb_config_file\*" -Destination $docker_config_path_mongodb }

$ravendb_config_file = "..\configs\${ravendb_container_name}"
if (Test-Path -path $ravendb_config_file) { Copy-Item "$ravendb_config_file\*" -Destination $docker_config_path_ravendb }

$prometheus_config_file = "..\configs\${prometheus_container_name}"
if (Test-Path -path $prometheus_config_file) { Copy-Item "$prometheus_config_file\*" -Destination $docker_config_path_prometheus }

$rabbitmq_config_file = "..\configs\${rabbitmq_container_name}"
if (Test-Path -path $rabbitmq_config_file) { Copy-Item "$rabbitmq_config_file\*" -Destination $docker_config_path_rabbitmq }

$pgadmin_config_file = "..\configs\${pgadmin_container_name}"
if (Test-Path -path $pgadmin_config_file) { Copy-Item "$pgadmin_config_file\*" -Destination $docker_config_path_pgadmin }

$mongoclient_config_file = "..\configs\${mongoclient_container_name}"
if (Test-Path -path $mongoclient_config_file) { Copy-Item "$mongoclient_config_file\*" -Destination $docker_config_path_mongoclient }

$grafana_config_file = "..\configs\${grafana_container_name}"
if (Test-Path -path $grafana_config_file) { Copy-Item "$grafana_config_file\*" -Destination $docker_config_path_grafana }

$sonarqube_config_file = "..\configs\${sonarqube_container_name}"
if (Test-Path -path $sonarqube_config_file) { Copy-Item "$sonarqube_config_file\*" -Destination $docker_config_path_sonarqube }

#
# extensions files
#
Write-Output "copy config files"

$sonarqube_extensions_file = "..\extensions\${sonarqube_container_name}"
if (Test-Path -path $sonarqube_extensions_file) { Copy-Item "$sonarqube_extensions_file\*" -Destination $docker_extensions_path_sonarqube }


#
# create network
#

Write-Output "create network"
docker network create --subnet=172.${ip_second_octect}.0.0/16 ${environment_name}

#
# create docker volume
#

Write-Output "create docker volume"
Write-Output "create volume directories"
New-Item -ItemType Directory -Force -Path "$docker_volume_path"

#
# create docker config
#

Write-Output "create docker config"
$docker_config = "C:\docker\configs"
Write-Output "create config directory"
$docker_config_path = Join-Path -Path "${docker_config}" -ChildPath "${environment_name}"
New-Item -ItemType Directory -Force -Path "$docker_config_path"

#
# copy compose file
#

Write-Output "copy compose file"
Copy-Item "..\templates\docker-compose.yml" -Destination "..\generated\environments\${environment_name}\docker-compose.yml"

#
# copy compose file
#

Write-Output "copy compose file"
Copy-Item "..\templates\docker-compose.yml" -Destination "..\generated\environments\${environment_name}\docker-compose.yml"

#
# set variables
#

Write-Output "set variables"

Set-Location ..\generated\environments\${environment_name}

docker-compose.exe up -d

Set-Location ..\..\..\scripts | Write-Output
