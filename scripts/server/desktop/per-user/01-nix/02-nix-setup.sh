#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

if ! [ -f "hm" ]; then
	echo "hm doesn't exist"
	exit 1
fi

mkdir -p "$HOME/.local/bin"
cp hm "$HOME/.local/bin/hm"
chmod 755 "$HOME/.local/bin/hm"

mkdir -p "$HOME/.config/nix"
touch "$HOME/.config/nix/nix.conf"

if ! ( cat "$HOME/.config/nix/nix.conf" | grep -q 'experimental-features = nix-command flakes' ); then
    echo 'experimental-features = nix-command flakes' >> "$HOME/.config/nix/nix.conf"
fi
