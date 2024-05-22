# kickstart.nvim

## Install dependencies

Install WSL

```
wsl --install -d Ubuntu

```

Create your user and password

Modify Windows Paths

```
echo "
[interop]
appendWindowsPath = false" | sudo tee -a /etc/wsl.conf
exit

```

```
wslconfig /t Ubuntu
wsl -d Ubuntu

```

```
cd ~
echo "export PATH=\$PATH:/mnt/c/Windows/System32/" | tee -a .bashrc
source .bashrc
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y make gcc ripgrep fd-find unzip git xclip neovim python3 python3-venv python3-pip nodejs npm wslu
sudo apt-get install -y wget apt-transport-https software-properties-common
source /etc/os-release
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y powershell
pwsh -command Install-Module PSScriptAnalyzer -force
sudo npm cache clean --force
sudo npm install -g n
sudo n latest
source ~/.bashrc
sudo npm install -g yarn
sudo npm install -g neovim
python3 -m pip install --user --upgrade pynvim
git clone https://github.com/DDTully/kickstart.wsl.git ~/.config/nvim
nvim

```
