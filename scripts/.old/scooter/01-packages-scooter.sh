#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

packages="
vim
nano
curl
wget
rdate
tmux
jq
fzf
caca-utils
gthumb
feh
mpv
udisks2
udiskie
autofs
bluetooth
bluez
blueman
gpsd
gpsd-clients
mosquitto
mosquitto-clients
docker.io
docker-compose
dnsmasq
hostapd
ffmpeg
fswebcam
v4l-utils
netcat-openbsd
net-tools
nmap
neofetch
socat
openssh-server
"

# Build/Software Installation Stuff
packages+="
ca-certificates
tk-dev
build-essential
gcc
make
cmake
dkms
doxygen
bc
autoconf
gstreamer1.0-libav
"

# Libs
packages+="
libavcodec-extra
libgdbm-dev
libc6-dev
libbz2-dev
libical-dev
libudev-dev
libusb-1.0-0-dev
libglib2.0-dev
libcairo2-dev
libgirepository1.0-dev
libsystemd-dev
libusb-dev
libdbus-1-dev
libreadline-dev
libncursesw5-dev
libssl-dev
libsqlite3-dev
libelf-dev
"

# Python packages
packages+="
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
python3-pytest
python3-docutils
python3-systemd
python3-opencv
python3-autopep8
python3-flask
python3-flask-socketio
python3-netifaces
python3-wheel
python3-requests
python3-websocket
python3-socketio
python3-socketio-client
python3-numpy
python3-dotenv
"

read -p "Do you want to install Network Manager (y/N)? " userInput

if ([ "$userInput" == "Y" ] || [ "$userInput" == "y" ]); then
packages+="
network-manager
"
fi

packages=${packages//$'\n'/ }
packages=$(echo "$packages" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

apt update && apt upgrade -y
apt install $packages -y
