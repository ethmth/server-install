#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi

cd "$HOME/openair-vpn/"
./set_vars.sh
./install_to_bin.sh
cd "$HOME/openair-vpn/systemd"
sudo ./install-services.sh
cd

# Disable killswitch and auto-connect for server
sudo systemctl disable vpn-killswitch.service
sudo systemctl disable vpn-connect.service

echo "You should be able to connect using 'vpn connect'"