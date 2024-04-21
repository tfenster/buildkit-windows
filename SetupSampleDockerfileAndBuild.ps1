# based on https://techcommunity.microsoft.com/t5/containers/getting-started-build-a-basic-hello-world-image-with-buildkit/ba-p/4096154 and https://docs.docker.com/build/buildkit/#buildkit-on-windows

Write-Host "Create Dockerfile etc."

Set-Location "buildkit-windows-test\sample-dockerfile"
Set-Content Dockerfile @"
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022
USER ContainerAdministrator
COPY hello.txt C:/
RUN echo "Goodbye!" >> hello.txt
CMD ["cmd", "/C", "type C:\\hello.txt"]
"@

Set-Content hello.txt @"
Hello from the buildkit Windows test scripts by Tobias Fenster!
This message shows that your installation appears to be working correctly.
"@

Write-Host "Add builder"
if (-not (docker buildx ls --format "{{.Name}}" | Where-Object { $_ -eq "buildkit-exp" })) { 
  docker buildx create --name buildkit-exp --use --driver=remote npipe:////./pipe/buildkitd 
}
docker buildx inspect
docker buildx build -t buildkit-sample --load . 

Write-Host "Run container"
docker run buildkit-sample
