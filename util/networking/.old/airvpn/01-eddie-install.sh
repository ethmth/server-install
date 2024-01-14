#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

CUR_USER=$(whoami)

mkdir -p /home/$CUR_USER/programs
wget -O /home/$CUR_USER/programs/eddie.deb "https://airvpn.org/mirrors/eddie.website/download/?platform=linux&arch=aarch64&ui=cli&format=debian.deb&version=2.21.8&r=0.9345900603024765"

sudo -k apt install /home/$CUR_USER/programs/eddie.deb
