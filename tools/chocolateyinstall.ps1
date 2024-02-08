$packageName = 'custom-node'
$url = 'https://nodejs.org/dist/v18.18.2/node-v18.18.2-darwin-x64.tar.gz'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Set-Location $toolsDir

New-Item -ItemType Directory -Name "custom-node"

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

Write-Host "Node path: $nodePath"
Write-Host "Node global path: $nodeGlobalPath"


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
Write-Host "Successfully installed fdk $fdkVersion."