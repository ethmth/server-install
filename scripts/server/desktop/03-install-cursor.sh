#!/usr/bin/env bash


if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

# Add Cursor's GPG key
curl -fsSL https://downloads.cursor.com/keys/anysphere.asc | gpg --dearmor | tee /etc/apt/keyrings/cursor.gpg > /dev/null

# Add the Cursor repository
echo "deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/cursor.gpg] https://downloads.cursor.com/aptrepo stable main" | tee /etc/apt/sources.list.d/cursor.list > /dev/null

# Update and install
apt update
apt install cursor
