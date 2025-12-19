#!/bin/bash

USER=$1
DEFAULT_GROUPS="cdrom floppy sudo audio dip video plugdev users netdev docker"

if [ "$USER" == "" ]; then
    echo "Usage: ./add-user.sh <username>"
    exit 1
fi


if [[ $EUID -ne 0 ]]; then
    echo "This script should be run with root/sudo privileges."
    exit 1
fi
IFS=' ' read -r -a GROUPS_ARRAY <<< "$DEFAULT_GROUPS"
GROUPS_COMMA=$(IFS=,; echo "${GROUPS_ARRAY[*]}")

read -p "Do you want to add the user to groups $GROUPS_COMMA (y/N)? " userInput

useradd -m $USER

passwd $USER

usermod -s /bin/bash $USER

if ([ "$userInput" == "Y" ] || [ "$userInput" == "y" ]); then
	usermod -aG "$GROUPS_COMMA" "$USER"
fi
