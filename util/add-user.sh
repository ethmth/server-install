#!/bin/bash

USER=$1

if [ "$USER" == "" ]; then
    echo "Usage: ./add-user.sh <username>"
    exit 1
fi


if [[ $EUID -ne 0 ]]; then
    echo "This script should be run with root/sudo privileges."
    exit 1
fi

useradd -m $USER