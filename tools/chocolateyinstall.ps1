$packageName = 'custom-node'
$url = 'https://nodejs.org/dist/v18.18.2/node-v18.18.2-darwin-x64.tar.gz'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Set-Location $toolsDir

New-Item -ItemType Directory -Name "custom-node" -Force

$packageDir = Join-Path $toolsDir $packageName

Write-Host "custom node folder created here $packageDir"

# Change the current directory to the selected folder
Set-Location $packageDir


# Clear-Host
Write-Host "Installing the FDK"

$nodeVersion = "v18.12.1"
$npmVersion = "8.19.2"


$nodePath = Join-Path $packageDir  "\node18\node-$nodeVersion-win-x64;"
$nodeGlobalPath = Join-Path $packageDir  "\node18\node_global;"
$nodeCachePath = Join-Path $packageDir  "\node18\node_cache"

Write-Host "Node path: $nodePath"
Write-Host "Node global path: $nodeGlobalPath"
Write-Host "Node cache path: $nodeCachePath"

# # Download Node.js
Invoke-WebRequest -Uri "https://nodejs.org/dist/v18.12.1/node-$nodeVersion-win-x64.zip" -OutFile "node-$nodeVersion-win-x64.zip"

# # # Unzip the downloaded Node.js archive
Expand-Archive "node-$nodeVersion-win-x64.zip"  'node18'

# # Update the PATH environment variable

$env:PATH =$nodePath+ $env:PATH
$env:PATH =$nodeGlobalPath+ $env:PATH

$nodeGlobalPath = Join-Path $packageDir  "\node18\node_global"
$nodeCachePath = Join-Path  $packageDir  "\node18\node_cache"



Write-Host "Setting the global path for node"
npm config set prefix $nodeGlobalPath
npm config set cache $nodeCachePath

# Set-Location $curDir

# # Get node version
$nodeVer = node -v

Write-Host "Node version: $nodeVer"

# Check node installation
if ($nodeVersion -eq $nodeVer) {
    Write-Host "Installation of node successful!"
} else {
    Write-Host "Installation of node failed! Please try again."
    exit
}

# Get npm version
$npmVer = npm -v

Write-Host "NPM version: $npmVer"

# Check npm installation
if ($npmVersion -eq $npmVer) {
    Write-Host "Installation of npm successful!"
} else {
    Write-Host "Installation of npm failed! Please try again."
    exit
}

npm install 'https://cdn.freshdev.io/fdk/latest.tgz' --global

$fdkVersion = fdk -v

Write-Host "FDK version: $fdkVersion"


# This file is used to package the source code of the module

Write-Host "Creating a source file to load the FDK in new terminal"

# Change the current directory to the selected folder
Set-Location "C:\Program Files"
New-Item -ItemType Directory -Name "Fdk" -Force

Set-Location $packageDir

# dynamically get the the location of the loadFdk.ps1 file 
$loadFdkFilePathToSave = "C:\fdk\loadFdk.ps1"

# Define the path to the LoadFDK.ps1 file
$scriptToInvoke = Join-Path $toolsDir "loadFdk.ps1"


Write-Host  "Use below path to load the FDK in new terminal"
Write-Host  $loadFdkFilePathToSave

# Content to be added
$loadFdkFileContent = @"
# Contents of LoadFDK.ps1
# This script invokes another PowerShell script

# Define the path to the script you want to invoke
`$scriptToInvoke = '$scriptToInvoke'

# Check if the script exists
if (Test-Path `$scriptToInvoke) {
    # If the script exists, invoke it
    Invoke-Expression -Command "`$scriptToInvoke"
} else {
    Write-Host "Error: The specified script '`$scriptToInvoke' does not exist."
}
"@

Remove-Item -Path $loadFdkFilePathToSave -Force -ErrorAction SilentlyContinue

# Save the content to the file
$loadFdkFileContent | Out-File -FilePath $loadFdkFilePathToSave -Force

