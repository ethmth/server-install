#!/usr/bin/env bash

CONTAINER_NAME="gluetun"

VOLUMES="
"

FILES="
wg0.conf
compose.yml
"

if ! [[ $EUID -ne 0 ]]; then
    echo "This script should not be run with root/sudo privileges."
    exit 1
fi

LOC="$HOME/docker"
mkdir -p "$LOC/$CONTAINER_NAME"

for file in $FILES; do
    if [ -d "$file" ]; then
        cp -r $file $LOC/$CONTAINER_NAME/
    elif [ -f "$file" ]; then
        cp $file $LOC/$CONTAINER_NAME/$file
    fi
done

for vol in $VOLUMES; do
    mkdir -p $LOC/$CONTAINER_NAME/$vol
    chmod -R 777 $LOC/$CONTAINER_NAME/$vol
done

echo "Update/copy wg0.conf in/to installed directory. Replace domain name with IP address"

echo "Installed $CONTAINER_NAME to $LOC"
echo "Run 'docker compose up --build -d' to run"
echo "cd $LOC/$CONTAINER_NAME"