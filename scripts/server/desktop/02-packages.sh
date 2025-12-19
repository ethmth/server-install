#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

packages="
sddm
"

apt update && apt upgrade -y
apt install $packages -y
