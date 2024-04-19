# based on https://gist.github.com/maxkoshevoi/60d7b7910ad6ddcc6e1c9b656a8d0301 and https://techcommunity.microsoft.com/t5/containers/getting-started-build-a-basic-hello-world-image-with-buildkit/ba-p/4096154

Set-Location "containerd"
$containerdReleasesUri = "https://api.github.com/repos/containerd/containerd/releases/latest"
$containerdDownloadUrl = ((Invoke-WebRequest $containerdReleasesUri | ConvertFrom-Json).assets | Where-Object name -like "containerd-*-windows-amd64.tar.gz").browser_download_url
Write-Host "Found download URL $containerdDownloadUrl for containerd, fetching and expanding it"
Invoke-WebRequest -Uri $containerdDownloadUrl -OutFile "containerd-windows-amd64.tar.gz"
tar.exe xvf .\containerd-windows-amd64.tar.gz
Write-Host "Configuring containerd"
bin\containerd.exe config default | Out-File config.toml -Encoding ascii
((Get-Content -path config.toml -Raw) -replace 'C:\\\\ProgramData\\\\containerd', ((Get-Location) -replace '\\', '\\')) | Set-Content -Path config.toml
((Get-Content -path config.toml -Raw) -replace 'C:\\\\Program Files\\\\containerd', ((Get-Location) -replace '\\', '\\')) | Set-Content -Path config.toml
.\bin\containerd.exe -c .\config.toml