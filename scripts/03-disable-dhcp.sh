#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

systemctl stop dhcdcd
systemctl disable dhcpcd

systemctl stop NetworkManager
systemctl enable NetworkManager
systemctl start NetworkManager

