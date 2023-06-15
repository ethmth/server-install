#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

packages="
build-essential
cmake
doxygen
libusb-1.0-0-dev
libglib2.0-dev
bluetooth
bluez
blueman
python3
python3-dev
python3-pip
python3-pint
python3-tk
python3-nose
python3-nose2
python3-coverage
python3-pandas
python3-pexpect
python3-gps
python3-pytest
gpsd
gpsd-clients
gpsd-tools
mosquitto
mosquitto-clients
"
packages=${packages//$'\n'/ }
packages=$(echo "$packages" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

apt update && apt upgrade -y
apt install $packages -y
