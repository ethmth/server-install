#!/usr/bin/env bash

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

echo "GOOD TO GO"