#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

if [ -d "hyprland/" ]; then
	rm -rf "hyprland/"
fi

cp -r "$HOME/.config/home-manager/hyprland/" "hyprland"

