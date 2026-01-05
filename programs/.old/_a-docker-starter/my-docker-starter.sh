#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi

TIME_RESET=86400 # One Day

CUR_USER=$(whoami)
USER_ID=$(id -u)


if [ -f "$HOME/.myDockerFlag" ]; then

    file_content=$(cat "$HOME/.myDockerFlag" | xargs)

    if [[ $file_content =~ ^-?[0-9]+$ ]]; then
        BOOT_TIME=$(who -b | tr -s ' ' | cut -d' ' -f4,5)
        BOOT_TIME_UNIX=$(date -d "$BOOT_TIME" +%s)

        LAST_TIME_PLUS_OFFSET=$((file_content + TIME_RESET))

        CURRENT_TIME_UNIX=$(date +%s)

        if ([[ "$file_content" -gt "$BOOT_TIME_UNIX" ]] && [[ "$LAST_TIME_PLUS_OFFSET" -gt "$CURRENT_TIME_UNIX" ]]); then
            exit 0
        fi

    fi

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

CURRENT_TIME_UNIX=$(date +%s)
CURRENT_TIME_UNIX=$((CURRENT_TIME_UNIX - 60))
echo "$CURRENT_TIME_UNIX" > "$HOME/.myDockerFlag"