#!/usr/bin/env bash


if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

# Add Cursor's GPG key
curl -fsSL https://downloads.cursor.com/keys/anysphere.asc | gpg --dearmor | tee /etc/apt/keyrings/cursor.gpg > /dev/null

# Add the repository to Apt sources:
tee /etc/apt/sources.list.d/cursor.sources <<EOF
Types: deb
URIs: https://downloads.cursor.com/aptrepo
Suites: stable
Components: main
Architectures: amd64,arm64
Signed-By: /etc/apt/keyrings/cursor.gpg
EOF

# Update and install
apt update
apt install cursor
