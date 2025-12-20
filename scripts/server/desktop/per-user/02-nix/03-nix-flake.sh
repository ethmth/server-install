#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

if ! [ -f "flake.nix" ]; then
	echo "flake.nix not found"
	exit 1
fi

cp "flake.nix" "$HOME/.config/home-manager/flake.nix"

echo "Copied flake.nix to $HOME/.config/home-manager/flake.nix"
echo "Then, run 'hm switch' to generate the config (you may need to reset your shell first)"
