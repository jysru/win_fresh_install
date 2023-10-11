### Run as Admin PowerShell ###


## Install package manager
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))


## Install basic packages
choco install firefox vlc spotify sublimetext4 libreoffice-fresh 7zip -a


## Install gaming packages
choco install discord steam obs-studio -a


## Install development packages
choco install vscode git github-desktop marktext -a


## Install security packages
choco install protonvpn -a