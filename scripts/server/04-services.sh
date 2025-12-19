#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

systemctl disable gdm
systemctl disable lightdm
systemctl disable apache2