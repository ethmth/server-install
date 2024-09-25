#!/usr/bin/env bash

# Check if exactly one argument is passed
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

# Check if the argument is a valid user
if ! id "$1" &>/dev/null; then
    echo "User '$1' does not exist."
    exit 1
fi
USER="$1"

if [ "$UID" -eq 0 ]; then
    if [ -n "$SUDO_USER" ]; then
        echo "Running with sudo as user: $SUDO_USER"
        echo "Run this script as root directly."
        exit 1
    fi
else
    echo "This script must be run directly as root."
    exit 1
fi

echo "Enter your old user ($USER) login password to unwrap/rewrap passphrase."
# ecryptfs-unwrap-passphrase /home/.ecryptfs/$USER/.ecryptfs/wrapped-passphrase

# echo "Copy the passphrase above and paste it as your old passphrase in the next step:"
echo "Set your new passprhase to your new password."
ecryptfs-rewrap-passphrase /home/.ecryptfs/$USER/.ecryptfs/wrapped-passphrase
