#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
    echo "This script should not be run with root/sudo privileges."
    exit 1
fi

CA_FILE="$HOME/certs/internalCA.crt"

if ! [ -f "$CA_FILE" ]; then
    echo "$CA_FILE not found."
    exit 1
fi


sudo trust anchor --store "$CA_FILE"