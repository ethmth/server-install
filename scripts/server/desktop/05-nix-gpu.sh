#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

OUTPUT=$(home-manager switch)

EXE=$(echo "$OUTPUT" | grep "non-nixos-gpu-setup" | head -1 | xargs | cut -d' ' -f2)

if ! [ -f "$EXE" ]; then
	echo "non-nixos-gpu-setup NOTE not auto-detected, doing nothing."
	echo "Run home-manager switch and ensure there are no warnings/notes"
	exit 1
fi

echo "Running sudo $EXE"

sudo "$EXE"
