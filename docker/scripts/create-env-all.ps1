Write-Output "*****************************************"
Write-Output "create development environment"
Write-Output "*****************************************"
.\create-env-development.ps1
docker ps -q | ForEach-Object { docker stop $_ }

Write-Output "*****************************************"
Write-Output "create testing environment"
Write-Output "*****************************************"
.\create-env-testing.ps1
docker ps -q | ForEach-Object { docker stop $_ }

Write-Output "*****************************************"
Write-Output "create stagging environment"
Write-Output "*****************************************"
.\create-env-stagging.ps1
docker ps -q | ForEach-Object { docker stop $_ }

Write-Output "*****************************************"
Write-Output "create production environment"
Write-Output "*****************************************"
.\create-env-production.ps1
docker ps -q | ForEach-Object { docker stop $_ }
