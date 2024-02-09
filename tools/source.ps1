
$packageDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageDir

$loadFdkFilePathToSave = "C:\FDK\loadFdk.ps1"
# Define the path to the LoadFDK.ps1 file
$loadFdkFilePath = Join-Path $packageDir "loadFdk.ps1"

# Define the path to the script you want to invoke
$scriptToInvoke = $loadFdkFilePath

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

