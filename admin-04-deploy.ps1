Param(
  [parameter(Position=0, Mandatory=$true)][String]$envGitUser
, [parameter(Position=1, Mandatory=$true)][String]$envGitEmail
, [parameter(Position=2, Mandatory=$true)][String]$envHome
)

function symLinkCreate ($Destination, $Source) {
  New-Item -ItemType SymbolicLink -Path $Destination -Value $Source
}

function symLinkDelete ($Target) {
  (Get-Item $Target).Delete()
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

symLinkDelete "$envConfig\autohotkey"
symLinkDelete "$envConfig\git"
symLinkDelete "$envConfig\vim"

Remove-Item -Recurse -Force "$envCache"
Remove-Item -Recurse -Force "$envConfig"
Remove-Item -Recurse -Force "$envRepos"

if ((Split-Path -NoQualifier $envHome) -ne "") {
  New-Item -ItemType Directory "$envHome"
}
New-Item -ItemType Directory "$envCache"
New-Item -ItemType Directory "$envConfig"
New-Item -ItemType Directory "$envRepos"

# git config --global user.name $envGitUser
# git config --global user.email $envGitEmail
git config --global core.autoCRLF false

git clone "https://github.com/chimre/dotfiles.git" "$envRepos\github.com\chimre\dotfiles"
git clone "https://github.com/chimre/kittingtool.git" "$envRepos\github.com\chimre\kittingtool"

symLinkCreate "$envConfig\autohotkey" "$envRepos\github.com\chimre\dotfiles\autohotkey"
symLinkCreate "$envConfig\git" "$envRepos\github.com\chimre\dotfiles\git"
symLinkCreate "$envConfig\vim" "$envRepos\github.com\chimre\dotfiles\vim"

git config --global include.path "$envConfig/git/10-common.conf"

symLinkDelete "$env:LOCALAPPDATA\nvim\init.vim"

Remove-Item -Recurse -Force "$env:LOCALAPPDATA\nvim"

New-Item -ItemType Directory "$env:LOCALAPPDATA\nvim"

symLinkCreate "$env:LOCALAPPDATA\nvim\init.vim" "$envConfig\vim\init.vim"

nvim -c q

$files = Get-ChildItem -Name "$envConfig\autohotkey\*.ahk"
foreach ($file in $files) {
  symLinkDelete "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\$file"
  symLinkCreate "$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\$file" "$envConfig\autohotkey\$file"
}

git clone --recursive "https://github.com/getpelican/pelican-plugins" "$envRepos\github.com\getpelican\pelican-plugins"
git clone --recursive "https://github.com/getpelican/pelican-themes" "$envRepos\github.com\getpelican\pelican-themes"

