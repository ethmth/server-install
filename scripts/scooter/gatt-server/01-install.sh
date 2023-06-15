#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

CUR_USER=$(whoami)

echo "$CUR_USER"

REPO="https://github.com/ykasidit/bluez-gatt-server.git"
INSTALLATION_DIR="/home/$CUR_USER/Projects/"

git clone
