Write-Host "Creating file structure (and remove existing, if it exists)"
if (Test-Path -Path "buildkit-windows-test") {
    Remove-Item -Path "buildkit-windows-test" -Recurse -Force
}
New-Item -Name "buildkit-windows-test" -ItemType Directory
Set-Location "buildkit-windows-test"
New-Item -Name "containerd" -ItemType Directory 
New-Item -Name "buildkit" -ItemType Directory 
New-Item -Name "sample-dockerfile" -ItemType Directory 