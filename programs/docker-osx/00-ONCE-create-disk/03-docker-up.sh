#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$SCRIPT_DIR"

if ! [ -f "docker-compose.yml" ]; then
    echo "docker-compose.yml doesn't exist. Exiting"
    exit 1
fi

docker compose up --build -d

echo "Docker container docker-osx-image running in background."
echo "Connect to VNC localhost:5900 with user:password"
echo "Format the disk with APFS, then install Sonoma."
echo "Setup OS with credentials user:alpine."
echo "Run ./03-extract-disk.sh when done."