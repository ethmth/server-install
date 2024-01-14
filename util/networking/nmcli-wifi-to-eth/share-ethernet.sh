#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script should be run with root/sudo privileges."
	exit 1
fi

nmcli con modify "Wired Connection 1" ipv4.method shared