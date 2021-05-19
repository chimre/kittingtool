# Developer PowerShell for VS 2019で実行する
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# build
choco upgrade make --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade cmake --install-if-not-installed --failonstderr -y
$installedPath = (Get-Command nvcc).Source | Split-Path -Parent
[System.Environment]::SetEnvironmentVariable("CMAKE_CUDA_COMPILER", "$installedPath", [System.EnvironmentVariableTarget]::User)
refreshenv

# runtime
choco upgrade adoptopenjdkjre --install-if-not-installed --failonstderr -y
refreshenv

# language
choco upgrade python --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade nodejs --install-if-not-installed --failonstderr -y
refreshenv

# utility
choco upgrade ripgrep --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade fzf --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade git --install-if-not-installed --failonstderr -y
refreshenv

# editor
choco upgrade neovim --install-if-not-installed --failonstderr -y --pre
refreshenv

choco upgrade winmerge --install-if-not-installed --failonstderr -y
$installedPath = (Get-Command WinMergeU).Source | Split-Path -Parent
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$installedPath", [System.EnvironmentVariableTarget]::User)
refreshenv

# archiver
choco upgrade peazip --install-if-not-installed --failonstderr -y
$installedPath = (Get-Command peazip).Source | Split-Path -Parent
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$installedPath", [System.EnvironmentVariableTarget]::User)
refreshenv

# application
choco upgrade docker-toolbox --install-if-not-installed --failonstderr -y
$installedPath = (Get-Command docker).Source | Split-Path -Parent
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$installedPath", [System.EnvironmentVariableTarget]::User)
refreshenv

choco upgrade virtualbox --install-if-not-installed --failonstderr -y
$installedPath = (Get-Command virtualbox).Source | Split-Path -Parent
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$installedPath", [System.EnvironmentVariableTarget]::User)
refreshenv

choco upgrade graphviz --install-if-not-installed --failonstderr -y
$installedPath = (Get-Command dot).Source
[System.Environment]::SetEnvironmentVariable("GRAPHVIZ_DOT", "$installedPath", [System.EnvironmentVariableTarget]::User)
refreshenv

choco upgrade winscp --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade authy-desktop --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade autohotkey --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade plantuml --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade adobereader --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade inkscape --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade gimp --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade libreoffice --install-if-not-installed --failonstderr -y
refreshenv

