Write-Output "*****************************************"
Write-Output "up development environment"
.\up-env-development.ps1

Write-Output "*****************************************"
Write-Output "up testing environment"
.\up-env-testing.ps1

Write-Output "*****************************************"
Write-Output "up stagging environment"
.\up-env-stagging.ps1

Write-Output "*****************************************"
Write-Output "up production environment"
.\up-env-production.ps1

# stop all container for development purposes
docker ps -q | ForEach-Object { docker stop $_ }