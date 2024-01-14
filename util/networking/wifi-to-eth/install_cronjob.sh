#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi
CUR_USER=$(whoami)

crontab -l | { cat; echo "@reboot bash /home/$CUR_USER/server-install/util/networking/wifi-to-eth/wifi-to-eth-route.sh"; } | crontab -