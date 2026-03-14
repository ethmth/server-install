#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
    echo "This script should not be run with root/sudo privileges."
    exit 1
fi

if ! [ -f "$HOME/certs/internalCA.crt" ]; then
    echo "$HOME/certs/internalCA.crt not found."
    exit 1
fi


sudo trust anchor --store "$HOME/certs/internalCA.crt"