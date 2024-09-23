#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run with root/sudo privileges."
	exit 1
fi

if ! [ -f "20-intel.conf" ]; then
  echo "20-intel.conf missing. Doing nothing."
  exit 1
fi

cp 20-intel.conf /etc/X11/xorg.conf.d/20-intel.conf