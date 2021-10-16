$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
refreshenv

choco upgrade chocolatey --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade microsoft-windows-terminal --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade powershell-core --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade visualstudio2019buildtools --package-parameters "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --includeOptional --passive" --install-if-not-installed --failonstderr -y
refreshenv

# Developer PowerShell for VS 2019で実行する
powershell.exe -Command {New-Item -ItemType Directory -Force (Split-Path $profile -Parent); $installedPath = (Get-Command Microsoft.VisualStudio.DevShell.dll).Source; Write-Output "Import-Module ""$installedPath""" | Out-File $profile; Write-Output "Enter-VsDevShell d2d1568b -DevCmdArguments ""-arch=x64 -no_logo""" | Out-File $profile -Append}

pwsh.exe -Command {New-Item -ItemType Directory -Force (Split-Path $profile -Parent); $installedPath = (Get-Command Microsoft.VisualStudio.DevShell.dll).Source; Write-Output "Import-Module ""$installedPath""" | Out-File $profile; Write-Output "Enter-VsDevShell d2d1568b -DevCmdArguments ""-arch=x64 -no_logo""" | Out-File $profile -Append}

# 手動でCUDAインストーラーを起動しCUDAをインストールする
# 手動でcuDNN(zip)を展開し$installedPathにコピーする

$installedPath = (Get-Command nvcc).Source | Split-Path -Parent | Split-Path -Parent
[System.Environment]::SetEnvironmentVariable("CUDA_HOME", "$installedPath", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("C_INCLUDE_PATH", $installedPath + "\include", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("LD_LIBRARY_PATH", $installedPath + "\lib\x64", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$installedPath\extras\CUPTI\lib64;$installedPath\include", [System.EnvironmentVariableTarget]::User)
refreshenv

# 環境反映のため再起動する

