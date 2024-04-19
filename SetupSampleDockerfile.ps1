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
