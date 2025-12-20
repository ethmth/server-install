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

if ! ( cat "$HOME/.bashrc" | grep -q "PATH=\$PATH:$HOME/.local/bin" ); then
echo "PATH=\$PATH:$HOME/.local/bin" >> "$HOME/.bashrc"
fi

echo "Restart your shell, and make sure the 'hm' command is visible"
