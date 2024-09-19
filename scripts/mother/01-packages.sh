#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

packages="
cups
printer-driver-dymo
sane
xsane
simple-scan
hplip
fzf
vim
nano
curl
wget
gallery-dl
yt-dlp
nmap
neofetch 
net-tools
speedtest-cli
netcat-openbsd
tmux
whois
unzip
jq
ca-certificates
feh
hexyl
ffmpeg
gparted
"

packages+="
make
gcc
"

packages+="
libavcodec-extra
gstreamer1.0-libav
gstreamer1.0-gtk3
heif-thumbnailer
webp
webp-pixbuf-loader
ffmpegthumbnailer
tumbler
tumbler-plugins-extra
"

packages=${packages//$'\n'/ }
packages=$(echo "$packages" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

apt update && apt upgrade -y
apt install $packages -y
