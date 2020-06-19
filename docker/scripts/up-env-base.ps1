Write-Output "create network"
docker network create --subnet=172.${network_ip_part}.0.0/16 $network_name

docker-compose.exe up ..\environments\${environment}\docker-compose.yml