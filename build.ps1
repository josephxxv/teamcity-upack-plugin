$ArtifactPath = "$PSScriptRoot\artifacts"
$TempPath = "$ArtifactPath\temp"
if (Test-Path $ArtifactPath) {
  Remove-Item $ArtifactPath -Force -Recurse
}

Copy-Item "$PSScriptRoot\plugin\agent" -Destination "$TempPath\agent" -Recurse
Compress-Archive -Path "$TempPath\agent\*" -CompressionLevel Optimal -DestinationPath "$TempPath\upack-metarunner.zip"
Remove-Item "$TempPath\agent" -Force -Recurse
Copy-Item "$PSScriptRoot\plugin" -Destination "$TempPath" -Recurse
Remove-Item "$TempPath\plugin\agent" -Force -Recurse
New-Item -Path "$TempPath\plugin\agent" -ItemType Directory | Out-Null
Move-Item -Path "$TempPath\upack-metarunner.zip" -Destination "$TempPath\plugin\agent\upack-metarunner.zip"
Compress-Archive -Path "$TempPath\plugin\*" -CompressionLevel Optimal -DestinationPath "$ArtifactPath\upack-metarunner.zip"
Remove-Item "$TempPath" -Force -Recurse