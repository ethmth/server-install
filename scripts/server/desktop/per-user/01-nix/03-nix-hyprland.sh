#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

if ! [ -d "config/" ]; then
	echo "config/ not found"
	exit 1
fi

if [ -d "$HOME/.config/home-manager/config" ]; then
	rm -rf "$HOME/.config/home-manager/config"
fi

cp -r "config/" "$HOME/.config/home-manager/config"

echo "Copied config/ to $HOME/.config/home-manager/config/"

echo "You must manually add the import to your home.nix config file:"
echo "vim $HOME/.config/home-manager/home.nix"
echo "  ...
  imports = [
    ./config/main.nix
    # ./nvidia.nix
  ];
  ..."
echo "Then, run 'home-manager switch' to regenerate the config. (or run the next scripts)"
