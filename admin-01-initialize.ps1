$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

choco upgrade chocolatey --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade microsoft-windows-terminal --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade powershell-core --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade visualstudio2019buildtools --install-if-not-installed --failonstderr -y
refreshenv

$lnkPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Visual Studio 2019\Visual Studio Tools\Developer PowerShell for VS 2019.lnk"
$WshShell = New-Object -ComObject WScript.Shell
$lnk = $WshShell.CreateShortcut($lnkPath)
$arguments = $lnk.Arguments.Split(" ")
if ($arguments[-1].Contains("-DevCmdArguments -arch=x64") -eq $False)
{
  if ($arguments[-1].EndsWith('}"') -eq $True)
  {
    $arguments[-1] = $arguments[-1].Replace('}"', ' -DevCmdArguments -arch=x64}"')
    $lnk.Arguments = [string]::Join(" ", $arguments)
    $lnk.save()
  }
}

# 手動でCUDAインストーラーを起動しCUDAをインストールする
# 手動でcuDNN(zip)を展開し$installedPathにコピーする

$installedPath = (Get-Command nvcc).Source | Split-Path -Parent | Split-Path -Parent
[System.Environment]::SetEnvironmentVariable("CUDA_HOME", "$installedPath", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("C_INCLUDE_PATH", $installedPath + "\include", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("LD_LIBRARY_PATH", $installedPath + "\lib\x64", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$installedPath\extras\CUPTI\lib64;$installedPath\include", [System.EnvironmentVariableTarget]::User)
refreshenv

# 環境反映のため再起動する

