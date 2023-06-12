#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

CUR_USER=$(whoami)

read -p "Please input your username: " username

read -p "Please input your password (will be echoed): " password

echo "$username" > /home/$CUR_USER/scripts/pia-ip/login.txt
echo "$password" >> /home/$CUR_USER/scripts/pia-ip/login.txt

piactl login /home/$CUR_USER/scripts/pia-ip/login.txt

pia-reconnect
