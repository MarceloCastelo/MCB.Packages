Write-Output "create network"
docker network create --subnet=172.${ip_second_octect}.0.0/16 $environment_name

Set-Location ..\environments\${environment_name}
docker-compose.exe up -d
Set-Location ..\..\scripts | Write-Output
