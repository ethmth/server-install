#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$SCRIPT_DIR"

if ! [ -f "docker-compose.yml" ]; then
    echo "docker-compose.yml doesn't exist. Exiting"
    exit 1
fi

docker compose down