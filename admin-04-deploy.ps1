Param(
  [parameter(Position=0, Mandatory=$true)][String]$envHome
)

function directoryCreate($Destination) {
  if ((Split-Path -NoQualifier $Destination) -ne "") {
    New-Item -ItemType Directory "$Destination"
  }
}

function symLinkCreate ($Destination, $Source) {
  if ((Split-Path -NoQualifier $Destination) -ne "") {
    (Get-Item $Destination).Delete()
  }
  New-Item -ItemType SymbolicLink -Path $Destination -Value $Source
}

$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

$envCache = "$envHome.cache"
$envConfig = "$envHome.config"
$envRepos = "$envHome.repos"

[System.Environment]::SetEnvironmentVariable("HOME", "$envHome", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("HOME_CACHE", "$envCache", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("HOME_CONFIG", "$envConfig", [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("HOME_REPOS", "$envRepos", [System.EnvironmentVariableTarget]::User)

refreshenv

directoryCreate "$envHome"
directoryCreate "$envCache"
directoryCreate "$envConfig"
directoryCreate "$envRepos"

git config --global core.autoCRLF false

git clone "https://github.com/chimre/dotfiles.git" "$envRepos\github.com\chimre\dotfiles"
git clone "https://github.com/chimre/kittingtool.git" "$envRepos\github.com\chimre\kittingtool"

symLinkCreate "$envConfig\autohotkey" "$envRepos\github.com\chimre\dotfiles\autohotkey"
symLinkCreate "$envConfig\git" "$envRepos\github.com\chimre\dotfiles\git"
symLinkCreate "$envConfig\nvim" "$envRepos\github.com\chimre\dotfiles\nvim"
symLinkCreate "$envConfig\nvim-data" "$envRepos\github.com\chimre\dotfiles\nvim-data"

git config --global include.path "$envConfig\git\common.conf"

symLinkCreate "$env:LOCALAPPDATA\nvim" "$envConfig\nvim"
symLinkCreate "$env:LOCALAPPDATA\nvim-data" "$envConfig\nvim-data"

nvim -e -s

$files = Get-ChildItem -Name "$envConfig\autohotkey\*.ahk"
foreach ($file in $files) {
  symLinkCreate "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\$file" "$envConfig\autohotkey\$file"
}

git clone --recursive "https://github.com/getpelican/pelican-plugins" "$envRepos\github.com\getpelican\pelican-plugins"
git clone --recursive "https://github.com/getpelican/pelican-themes" "$envRepos\github.com\getpelican\pelican-themes"

