
$postgresql_container_name="postgresql"
$mongodb_container_name="mongodb"



Set-Location ..\environments\${environment_name}

Clear-Content .\.env

Add-Content .\.env "postgresql_container_name=${postgresql_container_name}"
Add-Content .\.env "mongodb_container_name=${mongodb_container_name}"

Add-Content .\.env "environment_name=${environment_name}"
Add-Content .\.env "ip_second_octect=${ip_second_octect}"
Add-Content .\.env "environment_port_prefix=${environment_port_prefix}"
Add-Content .\.env "docker_volume=${docker_volume}"
