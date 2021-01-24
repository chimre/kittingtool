$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

choco upgrade microsoft-windows-terminal --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade powershell-core --install-if-not-installed --failonstderr -y
refreshenv

