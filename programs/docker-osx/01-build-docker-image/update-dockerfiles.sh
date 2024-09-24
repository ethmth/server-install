#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

if [ -f "Dockerfile" ]; then
    rm Dockerfile
fi

if [ -f "Dockerfile.naked" ]; then
    rm Dockerfile.naked
fi

wget https://raw.githubusercontent.com/sickcodes/Docker-OSX/refs/heads/master/Dockerfile
wget https://raw.githubusercontent.com/sickcodes/Docker-OSX/refs/heads/master/Dockerfile.naked
