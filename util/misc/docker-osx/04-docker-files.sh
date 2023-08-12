#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}")
cd $SCRIPT_RELATIVE_DIR
ABSOLUTE_PATH=$(pwd)

CUR_USER=$(whoami)

LOC=$(lsblk --noheadings -o MOUNTPOINTS | grep -v '^$' | grep -v "/boot" | fzf --prompt="Select your desired installation location")

if ([ "$LOC" == "" ] || [ "$LOC" == "Cancel" ]); then
    echo "Nothing was selected"
    echo "Run this script again with target drive mounted."
    exit 1
fi

if [ "$LOC" == "/" ]; then
    LOC="/home/$CUR_USER"
fi

if ! [ -d "$LOC" ]; then
    echo "Your location is not available. Is the disk mounted? Do you have access?"
	exit 1
fi

LOC="$LOC/programs/docker-osx"
mkdir -p $LOC
cd $LOC

if ! [ -e "$ABSOLUTE_PATH/docker-compose.yml" ]; then
    echo "docker-compose.yml doesn't exist in $ABSOLUTE_PATH"
fi

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
