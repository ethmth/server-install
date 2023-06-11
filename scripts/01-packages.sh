#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

packages="
network-manager
bluetooth
bluez
blueman
vim
nano
curl
wget
proxychains
tsocks
yt-dlp
gallery-dl
docker.io
docker-compose
nmap
neofetch
python3
python3-venv
python3-pip
python3-pint
python3-tk
python3-nose
python3-nose2
python3-coverage
python3-nose2-cov
python3-pandas
python3-pexpect
gpsd
python-gps
net-tools
speedtest-cli
netcat-openbsd
build-essential
dkms
make
cmake
gcc
libelf-dev
tmux
plocate
golang
rdate
leap-archive-keyring
libavcodec-extra
gstreamer1.0-libav
whois
openvpn
network-manager-openvpn
unzip
xvfb
libxi6
libgconf-2-4
p7zip-full
aria2
libgmp-dev
libpcap-dev
libbz2-dev
jq
ca-certificates
"
packages=${packages//$'\n'/ }
packages=$(echo "$packages" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

apt update && apt upgrade -y
apt install $packages -y
