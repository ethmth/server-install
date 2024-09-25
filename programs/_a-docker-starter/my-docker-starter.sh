#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi

CUR_USER=$(whoami)
USER_ID=$(id -u)

if [ -f "$HOME/.myDockerFlag" ]; then
    exit 0
fi

if ! [ -f "$HOME/.myDockerPrograms" ]; then
    exit 0
fi

while IFS= read -r line; do
    echo "$line"
    if ! [ -d "$line" ]; then
        continue
    fi

    cd "$line"
    if ! [ -f "docker-compose.yml" ]; then
        continue
    fi

    docker compose up -d

done < "$HOME/.myDockerPrograms"

touch "$HOME/.myDockerFlag"