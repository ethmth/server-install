#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

packages="
ecryptfs-utils
rsync
lsof
zip
cryptsetup
ncdu
postgresql-client-15
systemd-resolved
sshpass
fzf
vim
nano
curl
wget
proxychains
docker.io
docker-compose
socat
nmap
neofetch 
python3
python3-dev
python3-venv
python3-pip
python3-flask
python3-flask-socketio
net-tools
speedtest-cli
netcat-openbsd
tmux
plocate
golang
whois
openvpn
unzip
xvfb
jq
ca-certificates
caca-utils
hexyl
chromium
openjdk-17-jre
"

packages=${packages//$'\n'/ }
packages=$(echo "$packages" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

apt update && apt upgrade -y
apt install $packages -y
