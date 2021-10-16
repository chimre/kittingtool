$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# build
choco upgrade make --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade cmake --install-if-not-installed --failonstderr -y
$installedPath = (Get-Command nvcc).Source | Split-Path -Parent
[System.Environment]::SetEnvironmentVariable("CMAKE_CUDA_COMPILER", "$installedPath", [System.EnvironmentVariableTarget]::User)
refreshenv

choco upgrade protoc --install-if-not-installed --failonstderr -y
refreshenv

# library
choco upgrade openssl --install-if-not-installed --failonstderr -y
refreshenv

choco upgrade boost-msvc-14.2 --install-if-not-installed --failonstderr -y
$installedPath = "C:\local\boost_" + (choco list boost -lo).Split(" ")[3].Replace(".", "_")
[System.Environment]::SetEnvironmentVariable("BOOST_HOME", "$installedPath", [System.EnvironmentVariableTarget]::User)
refreshenv

# font
choco upgrade nerdfont-hack --install-if-not-installed --failonstderr -y
choco upgrade nerd-fonts-3270 --install-if-not-installed --failonstderr -y
choco upgrade font-hackgen --install-if-not-installed --failonstderr -y
choco upgrade font-hackgen-nerd --install-if-not-installed --failonstderr -y
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

choco upgrade fd --install-if-not-installed --failonstderr -y
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
$installedPath = (Get-ChildItem "$env:ProgramW6432" -Recurse -Include "docker.exe").FullName | Split-Path -Parent
#$installedPath = (Get-Command docker).Source | Split-Path -Parent
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$installedPath", [System.EnvironmentVariableTarget]::User)
refreshenv

choco upgrade virtualbox --install-if-not-installed --failonstderr -y
$installedPath = (Get-ChildItem "$env:ProgramW6432" -Recurse -Include "virtualbox.exe").FullName | Split-Path -Parent
#$installedPath = (Get-Command virtualbox).Source | Split-Path -Parent
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

