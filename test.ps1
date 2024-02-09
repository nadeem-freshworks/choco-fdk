# Get the installation directory of the "fdk" package
$packageName = "fdk"
 choco info $packageName --local-only 

# Extract the installation directory from the output
# $installationDirectory = $packageInfo | Select-String -Pattern "Location\s*:\s*(.*)" | ForEach-Object { $_.Matches.Groups[1].Value }

# # Display the installation directory
# Write-Output "Installation directory of $packageName: $installationDirectory"
