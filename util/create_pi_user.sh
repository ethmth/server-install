#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script should be run with root/sudo privileges."
	exit 1
fi

useradd -m pi

usermod -aG docker,wheel,adm,cdrom,dip,plugdev,lpadmin,lxd,sambashare pi

chsh -s /bin/bash pi

passwd pi