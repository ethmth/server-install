#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

packages="
bluetooth
bluez
blueman
vim
nano
curl
wget
proxychains
tsocks
gallery-dl
docker.io
docker-compose
socat
openssh-server
openresolv
nmap
neofetch 
python3
python3-dev
python3-venv
python3-pip
python3-pint
python3-tk
python3-nose
python3-nose2
python3-coverage
python3-pandas
python3-pexpect
python3-flask
python3-flask-socketio
python3-opencv
python3-autopep8
gpsd
gpsd-clients
gpsd-tools
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
unzip
xvfb
libxi6
libgconf-2-4
libglib2.0-dev
doxygen
p7zip-full
aria2
libgmp-dev
libpcap-dev
libbz2-dev
jq
ca-certificates
feh
caca-utils
hexyl
dnsmasq
hostapd
rustc
ffmpeg
fswebcam
v4l-utils
"

read -p "Do you want to install Network Manager (y/N)? " userInput

if ([ "$userInput" == "Y" ] || [ "$userInput" == "y" ]); then
packages+="
network-manager
network-manager-gnome
network-manager-openvpn
"
fi


packages=${packages//$'\n'/ }
packages=$(echo "$packages" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

apt update && apt upgrade -y
apt install $packages -y

systemctl disable gdm
systemctl disable lightdm
