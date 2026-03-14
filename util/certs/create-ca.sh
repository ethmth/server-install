#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
    echo "This script should not be run with root/sudo privileges."
    exit 1
fi

if [ -d "$HOME/certs" ]; then
    echo "~/certs already exists. Remove it to continue"
    exit 1
fi

mkdir -p ~/certs
cd ~/certs

export PASSWORD=""
openssl genrsa -des3 -passout env:PASSWORD -out internalCA.key 4096

export PASSWORD=""
openssl req -x509 -new -nodes -key internalCA.key -sha256 -passin env:PASSWORD -days 36500 -out internalCA.pem <<EOF
.
.
.
.
.
Internal CA
.
EOF

# cp ~/certs/myCA.pem ~/certs/myCA.crt
openssl x509 -outform der -in internalCA.pem -out internalCA.crt

