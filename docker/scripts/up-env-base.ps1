Write-Output "create network"
docker network create --subnet=172.${ip_second_octect}.0.0/16 ${environment_name}

Set-Location ..\environments\${environment_name}

Clear-Content .\.env
Add-Content .\.env "environment_name=${environment_name}"
Add-Content .\.env "ip_second_octect=${ip_second_octect}"
Add-Content .\.env "environment_port_prefix=${environment_port_prefix}"

docker-compose.exe up -d


Set-Location ..\..\scripts | Write-Output
