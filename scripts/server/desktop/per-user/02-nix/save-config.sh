#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

if [ -d "config/" ]; then
	rm -rf "config/"
fi

cp -r "$HOME/.config/home-manager/config/" "config"

