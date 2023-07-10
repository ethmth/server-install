#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi

CUR_USER=$(whoami)

sudo usermod -aG docker $CUR_USER

groups $CUR_USER

git config --global credential.helper store

echo "Verify that you were added to the correct groups"
