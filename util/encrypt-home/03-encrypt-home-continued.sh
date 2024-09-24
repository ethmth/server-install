#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
    echo "This script should NOT be run with root/sudo privileges."
    exit 1
fi

ecryptfs-mount-private

ecryptfs-unwrap-passphrase

echo "Reboot"