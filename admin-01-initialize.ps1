$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

$programFiles = [System.Environment]::GetEnvironmentVariable("ProgramFiles", [System.EnvironmentVariableTarget]::Process)
$programFiles86 = [System.Environment]::GetEnvironmentVariable("ProgramFiles(x86)", [System.EnvironmentVariableTarget]::Process)

choco upgrade microsoft-windows-terminal --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade powershell-preview --install-if-not-installed --failonstderr -y
refreshenv

