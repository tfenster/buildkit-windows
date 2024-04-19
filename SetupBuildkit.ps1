# based on https://gist.github.com/maxkoshevoi/60d7b7910ad6ddcc6e1c9b656a8d0301 and https://techcommunity.microsoft.com/t5/containers/getting-started-build-a-basic-hello-world-image-with-buildkit/ba-p/4096154

Set-Location "buildkit-windows-test\buildkit"
$buildkitReleasesUri = "https://api.github.com/repos/moby/buildkit/releases/latest"
$buildkitDownloadUrl = ((Invoke-WebRequest $buildkitReleasesUri | ConvertFrom-Json).assets | Where-Object name -like "buildkit-*.windows-amd64.tar.gz").browser_download_url
Write-Host "Found download URL $buildkitDownloadUrl for buildkit, fetching and expanding it"
Invoke-WebRequest -Uri $buildkitDownloadUrl -OutFile "buildkit-windows-amd64.tar.gz"
tar.exe xvf .\buildkit-windows-amd64.tar.gz
.\bin\buildkitd.exe