#!/usr/bin/env bash


if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

# Add Mega's GPG key
curl -fsSL https://mega.nz/keys/MEGA_signing.key | gpg --dearmor | tee /etc/apt/keyrings/meganz-archive-keyring.gpg > /dev/null

# Add the repository to Apt sources:
tee /etc/apt/sources.list.d/meganz.sources <<EOF
Types: deb
URIs: https://mega.nz/linux/repo/Debian_13
Suites: ./
Architectures: arm64,amd64
Signed-By: /etc/apt/keyrings/meganz-archive-keyring.gpg
EOF

# Add the repository to Apt sources:
# echo "deb [signed-by=/etc/apt/keyrings/meganz-archive-keyring.gpg] https://mega.nz/linux/repo/Debian_13/ ./" | tee /etc/apt/sources.list.d/meganz.list

# Update and install
apt update
apt install megasync thunar-megasync megacmd


echo "To login to Megasync, you will probably have to use the Awesome WM (awesome)"
