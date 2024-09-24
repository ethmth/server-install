#!/bin/bash

USER=$1

if [ "$USER" == "" ]; then
    echo "Usage: ./add-user.sh <username>"
    echo "Create a dummy user to login to to encrypt the other one."
    exit 1
fi


if [[ $EUID -ne 0 ]]; then
    echo "This script should be run with root/sudo privileges."
    exit 1
fi

useradd -m $USER

passwd $USER

usermod -s /bin/bash $USER