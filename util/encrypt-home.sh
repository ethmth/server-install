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

modprobe ecryptfs

ecryptfs-migrate-home -u "$USER"

echo "IMPORTANT: Login as $USER. Then, reboot."