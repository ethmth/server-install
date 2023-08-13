#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}")
cd $SCRIPT_RELATIVE_DIR
ABSOLUTE_PATH=$(pwd)

CUR_USER=$(whoami)

LOC="/home/$CUR_USER/programs/docker-osx"
mkdir -p $LOC
cd $LOC

if ! [ -e "$ABSOLUTE_PATH/docker-compose.yml" ]; then
    echo "docker-compose.yml doesn't exist in $ABSOLUTE_PATH"
fi

if ! [ -e "$LOC/OpenCore.qcow2" ]; then
    echo "OpenCore.qcow2 doesn't exist in $LOC"
fi

if ! [ -e "$LOC/mac_hdd_ng.img" ]; then
    echo "mac_hdd_ng.img doesn't exist in $LOC"
fi

if ! [ -e "$LOC/values.conf" ]; then
    echo "values.conf doesn't exist in $LOC"
fi

cp $LOC/values.conf $LOC/.env

password=""
read -p "Enter the password you want to use for VNC (will be echoed): " password
if [ "$password" == "" ]; then
    echo "No password specified."
    exit 1
fi

cp $ABSOLUTE_PATH/docker-compose.yml $LOC/docker-compose.yml

sed -i "s/PASSWORD/$password/g" $LOC/docker-compose.yml

echo "docker-compose.yml installed to $LOC"
echo "Run 'docker-compose up --build -d'"
echo "cd $LOC"
echo "======================================"
echo "After you're finished, connect to the Mac desktop using VNC (port 5999)"
echo "You can also connect to ssh (port 50922) using user:alpine as credentials."
echo "Run the next script once ssh is available to get Bluebubbles installation scripts on MacOS"