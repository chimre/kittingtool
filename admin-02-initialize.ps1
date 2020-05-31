$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

$programFiles = [System.Environment]::GetEnvironmentVariable("ProgramFiles", [System.EnvironmentVariableTarget]::Process)
$programFiles86 = [System.Environment]::GetEnvironmentVariable("ProgramFiles(x86)", [System.EnvironmentVariableTarget]::Process)

# make
choco upgrade make --install-if-not-installed --failonstderr -y
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
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$programFiles\WinMerge", [System.EnvironmentVariableTarget]::User)
refreshenv

# archiver
choco upgrade peazip --install-if-not-installed --failonstderr -y
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$programFiles\PeaZip", [System.EnvironmentVariableTarget]::User)
refreshenv

# application
choco upgrade docker-toolbox --install-if-not-installed --failonstderr -y
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$programFiles\Docker Toolbox", [System.EnvironmentVariableTarget]::User)
refreshenv

choco upgrade virtualbox --install-if-not-installed --failonstderr -y
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$programFiles\Oracle\VirtualBox", [System.EnvironmentVariableTarget]::User)
refreshenv

choco upgrade graphviz --install-if-not-installed --failonstderr -y
$graphvizVersion = $(choco list graphviz | rg Graphviz).Split(' ')[1].Split('.')[0..1] -join '.'
[System.Environment]::SetEnvironmentVariable("GRAPHVIZ_DOT", "$programFiles86\Graphviz$graphvizVersion\bin\dot.exe", [System.EnvironmentVariableTarget]::User)
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

