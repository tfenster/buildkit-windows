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
docker buildx create --name buildkit-exp --use --driver=remote npipe:////./pipe/buildkitd
docker buildx inspect
docker buildx build -t buildkit-sample --load . 
