#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

packages="
gthumb
mpv
udisks2
udiskie
autofs
build-essential
cmake
doxygen
bc
autoconf
libusb-dev
libdbus-1-dev
libreadline-dev
libncursesw5-dev
libssl-dev
libsqlite3-dev
tk-dev
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
bluetooth
bluez
blueman
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
gpsd
gpsd-clients
mosquitto
mosquitto-clients
docker.io
docker-compose
dnsmasq
hostapd
network-manager
rustc
"
packages=${packages//$'\n'/ }
packages=$(echo "$packages" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

apt update && apt upgrade -y
apt install $packages -y
