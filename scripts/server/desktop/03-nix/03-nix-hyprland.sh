#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

if ! [ -f "hyprland.nix" ]; then
	echo "hyprland.nix not found"
	exit 1
fi

cp "hyprland.nix" "$HOME/.config/home-manager/hyprland.nix"

echo "Copied hyprland.nix to $HOME/.config/home-manager/hyprland.nix"

echo "You must manually add the import to your home.nix config file:"
echo "vim $HOME/.config/home-manager/home.nix"
echo "  ...
  imports = [
    ./hyprland.nix
    # ./nvidia.nix
  ];
  ..."
echo "Then, run 'home-manager switch' to regenerate the config. (or run the next scripts)"
