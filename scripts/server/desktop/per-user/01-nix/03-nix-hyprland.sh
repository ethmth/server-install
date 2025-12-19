#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

if ! [ -d "hyprland/" ]; then
	echo "hyprland/ not found"
	exit 1
fi

if [ -d "$HOME/.config/home-manager/hyprland" ]; then
	rm -rf "$HOME/.config/home-manager/hyprland"
fi

cp -r "hyprland/" "$HOME/.config/home-manager/hyprland"

echo "Copied hyprland/ to $HOME/.config/home-manager/hyprland/"

echo "You must manually add the import to your home.nix config file:"
echo "vim $HOME/.config/home-manager/home.nix"
echo "  ...
  imports = [
    ./hyprland/hyprland.nix
    # ./nvidia.nix
  ];
  ..."
echo "Then, run 'home-manager switch' to regenerate the config. (or run the next scripts)"
