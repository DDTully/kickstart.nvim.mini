# kickstart.nvim

## Install dependencies

Open terminal as administrator

![image](https://github.com/DDTully/kickstart.nvim/assets/165563299/47417247-d33b-4866-9ae1-82ba64449184)

Install Chocolately

```pwsh
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol`
 = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;`
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

```

Install Neovim and additional dependencies

```pwsh
choco install fd ripgrep ripgrep-all make mingw nodejs gzip unzip 7zip wget git `
python3 python3-virtualenv nerd-fonts-Hack powershell-core neovim -y

```

Close the elevated Windows Terminal session and open a standard terminal session

![image](https://github.com/DDTully/kickstart.nvim/assets/165563299/410b2726-7269-4532-a59c-ab60db9a61ff)

This would be a great time to set Windows Terminal as your default terminal application,
Powershell 7 as your default profile, and change the font.

Hit CTRL-, to open settings, set the following options in Startup

![image](https://github.com/DDTully/kickstart.nvim/assets/165563299/fb83c457-484a-4e8f-beb4-602b5be8f3a8)

Under Profiles, Powershell, Appearance (scroll down in the right pane) set the following

![image](https://github.com/DDTully/kickstart.nvim/assets/165563299/1e9ac30d-5b80-4174-a270-e8f47d1d779b)

Click on save in the lower right corner, then close the terminal window.

Reopen Terminal, you should see something similar to below

![image](https://github.com/DDTully/kickstart.nvim/assets/165563299/5043c91f-9cb0-481d-ba0f-b6dd9fcc5950)

## Back up existing Neovim config if needed

```pwsh
Move-Item $ENV:LOCALAPPDATA\nvim $ENV:LOCALAPPDATA\nvim.bak
Move-Item $ENV:LOCALAPPDATA\nvim-data $ENV:LOCALAPPDATA\nvim-data.bak

```

## Clone repository, install PSScriptAnalyzer, and start nvim for the first time

It's gonna do a lot of stuff, give it some time.

```pwsh
git clone https://github.com/DDTully/kickstart.nvim.mini.git $ENV:LOCALAPPDATA\nvim
remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force
Install-Module PSScriptAnalyzer -force
npm install -g yarn
nvim

```
