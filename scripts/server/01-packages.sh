#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

sed -i '/^deb/ {/non-free-firmware/! s/$/ non-free-firmware/}' /etc/apt/sources.list

# echo "Explanation: Disable packages from non-free tree by default
# Package: *
# Pin: release o=Debian,a=stable,l=Debian,c=non-free
# Pin-Priority: -1" > /etc/apt/preferences.d/non-free_policy

# echo "Explanation: Enable package firmware-realtek from non-free tree
# Package: firmware-realtek
# Pin: release o=Debian,a=stable,l=Debian,c=non-free
# Pin-Priority: 600" > /etc/apt/preferences.d/firmware-realtek_nonfree

# linux-headers-amd64
packages="
apt-transport-https
dirmngr
software-properties-common
ecryptfs-utils
rsync
lsof
cryptsetup
yt-dlp
rcon
tigervnc-viewer
eog
sxiv
libsixel-bin
postgresql-client-15
qemu-utils
expect
sshpass
certbot
fzf
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
containerd
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
python3-bs4
python3-certbot-apache
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
libavcodec-extra
gstreamer1.0-libav
whois
openvpn
unzip
xvfb
doxygen
p7zip-full
aria2
jq
ca-certificates
feh
caca-utils
hexyl
hostapd
rustc
ffmpeg
fswebcam
v4l-utils
easy-rsa
"

packages+="
libgmp-dev
libpcap-dev
libbz2-dev
libxi6
libgconf-2-4
libglib2.0-dev
libseccomp2
"

read -p "Do you want to install Network Manager (y/N)? " userInput

if ([ "$userInput" == "Y" ] || [ "$userInput" == "y" ]); then
packages+="
network-manager
network-manager-gnome
network-manager-openvpn
"
fi

packages+="
firmware-realtek
firmware-amd-graphics
"

packages=${packages//$'\n'/ }
packages=$(echo "$packages" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

apt update && apt upgrade -y
apt install $packages -y
