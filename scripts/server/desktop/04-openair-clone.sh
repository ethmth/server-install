#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi

git clone https://github.com/ethmth/openair-vpn.git $HOME/openair-vpn

echo "Navigate to https://airvpn.org/generator/ and download AirVPN.zip into ~/.vpn/"
echo "Select Linux, OpenVPN TCP 443, Single Server (Invert Selection to Select All) "
echo "^ OR USE AZIREVPN"
echo "Edit $HOME/openair-vpn/vars/vars.conf"
echo "When DONE EDITING vars.conf, run ./05-openair-install.sh"
echo "vim $HOME/openair-vpn/vars/vars.conf"
