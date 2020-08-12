
function GetContainerNameCollection {
    $containerNameCollection = @();

    # Database and Caches
    $containerNameCollection += "postgresql", "mongodb", "ravendb", "prometheus";
    # Queues
    $containerNameCollection += "rabbitmq";
    # Other Apps
    $containerNameCollection += "pgadmin", "mongoclient", "grafana", "sonarqube";

    return $containerNameCollection;
}

function GetContainerPathCollection {
    param (
        $Path,
        $ContainerNameCollection
    )
    
    $containerPathCollection = @();

    foreach ($containerName in $ContainerNameCollection) {
        $containerPathCollection += Join-Path -Path $path -ChildPath $containerName;
    }

    return $containerPathCollection;
}
function CreatePathCollection {
    param (
        $PathCollection
    )

    foreach ($path in $PathCollection) {
        if (!(Test-Path -path $path)) { New-Item -ItemType Directory -Force -Path "$path" }
    }
}
function AddVolumeVariableToEnvFile {
    param (
        $EnvFileName,
        $ContainerName,
        $ContainerVolumePathCollection,
        $VolumeType
    )

    # add container volume data path
    $containerVolumePath = $ContainerVolumePathCollection | Where-Object{$_ -like "*$ContainerName"};
    if(!([string]::IsNullOrWhiteSpace($containerVolumePath)))
    {
        Add-Content $EnvFileName "${ContainerName}ContainerVolume${VolumeType}Path='$containerVolumePath'";
    }
}

function CopyContainerFiles {
    param (
        $SourcePath,
        $ContainerVolumePathCollection,
        $ContainerName
    )

    # add container volume data path
    $containerVolumePathVariable = $ContainerVolumePathCollection | Where-Object{$_ -like "*$ContainerName"};
    if( (!([string]::IsNullOrWhiteSpace($containerVolumePathVariable))) -and (Test-Path -path $SourcePath) -and (Test-Path -path $containerVolumePathVariable)  )
    {
        Copy-Item "$SourcePath\*" -Destination $containerVolumePathVariable -recurse;
    }
}

# the $environment_name variable, $ip_second_octect and $environment_port_prefix variables has defined in the caller script
Write-Host "create environment: $environmentName";


# general variables
$generatedEnvironmentPath = "..\..\generated\environments\$environmentName";
$envFilename = "$generatedEnvironmentPath\.env";

$templatesPath = "..\..\templates";
$configPath = "..\..\configs";
$extensionPath = "..\..\extensions";


# docker container path variables
$dockerPath = "C:\docker\";
$dockerVolumePath = Join-Path -Path "$dockerPath" -ChildPath "volumes";
$dockerVolumePath = Join-Path -Path "$dockerVolumePath" -ChildPath $environmentName;
$dockerVolumeDataPath = Join-Path -Path $dockerVolumePath -ChildPath "data";
$dockerVolumeConfigPath = Join-Path -Path $dockerVolumePath -ChildPath "config";
$dockerVolumeLogPath = Join-Path -Path $dockerVolumePath -ChildPath "log";
$dockerVolumeExtensionPath = Join-Path -Path $dockerVolumePath -ChildPath "extension";

$containerNameCollection = GetContainerNameCollection;

$containerVolumeDataPathCollection = GetContainerPathCollection -Path $dockerVolumeDataPath -ContainerNameCollection $containerNameCollection;
$containerVolumeConfigPathCollection = GetContainerPathCollection -Path $dockerVolumeConfigPath -ContainerNameCollection $containerNameCollection;
$containerVolumeLogPathCollection = GetContainerPathCollection -Path $dockerVolumeLogPath -ContainerNameCollection $containerNameCollection;
$containerVolumeExtensionPathCollection = GetContainerPathCollection -Path $dockerVolumeExtensionPath -ContainerNameCollection $containerNameCollection;

Write-Host "create paths";
CreatePathCollection -PathCollection $generatedEnvironmentPath;
CreatePathCollection -PathCollection $containerVolumeDataPathCollection;
CreatePathCollection -PathCollection $containerVolumeConfigPathCollection;
CreatePathCollection -PathCollection $containerVolumeLogPathCollection;
CreatePathCollection -PathCollection $containerVolumeExtensionPathCollection;

Write-Host "create env file"
if(Test-Path -path $envFilename) 
{
    Clear-Content $envFilename 
}

Add-Content $envFilename "environmentName=""$environmentName""";
Add-Content $envFilename "ipSecondOctect=$ipSecondOctect";
Add-Content $envFilename "environmentPortPrefix=$environmentPortPrefix";
Add-Content $envFilename "";

foreach($containerName in $containerNameCollection)
{
    # add container name variable
    Add-Content $envFilename "${containerName}ContainerName=""$containerName""";

    # add container volumes paths
    AddVolumeVariableToEnvFile -EnvFileName $envFilename -ContainerName $containerName -ContainerVolumePathCollection $containerVolumeDataPathCollection -VolumeType "Data";
    AddVolumeVariableToEnvFile -EnvFileName $envFilename -ContainerName $containerName -ContainerVolumePathCollection $containerVolumeConfigPathCollection -VolumeType "Config";
    AddVolumeVariableToEnvFile -EnvFileName $envFilename -ContainerName $containerName -ContainerVolumePathCollection $containerVolumeLogPathCollection -VolumeType "Log";
    AddVolumeVariableToEnvFile -EnvFileName $envFilename -ContainerName $containerName -ContainerVolumePathCollection $containerVolumeExtensionPathCollection -VolumeType "Extension";
    
    Add-Content $envFilename "";
}

Write-Host "copy config and extensions containers files"
foreach($containerName in $containerNameCollection)
{
    $containerConfigSourcePath = Join-Path -Path $configPath -ChildPath $containerName;
    $containerExtensionSourcePath = Join-Path -Path $extensionPath -ChildPath $containerName;

    CopyContainerFiles -SourcePath $containerConfigSourcePath -ContainerVolumePathCollection $containerVolumeConfigPathCollection -ContainerName $containerName;
    CopyContainerFiles -SourcePath $containerExtensionSourcePath -ContainerVolumePathCollection $containerVolumeExtensionPathCollection -ContainerName $containerName;
}

Write-Host "copy template file"
foreach($containerName in $containerNameCollection)
{
    Copy-Item "$templatesPath\*" -Destination $generatedEnvironmentPath;
}


Write-Host "create docker network"
docker network create --subnet=172.${ipSecondOctect}.0.0/16 ${environmentName};

Write-Host "up compose file"
Set-Location $generatedEnvironmentPath;
docker-compose.exe up -d

Set-Location ..\..\..\scripts\creation

docker ps -q | ForEach-Object { docker stop $_ }
