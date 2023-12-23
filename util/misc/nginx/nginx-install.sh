#!/bin/bash

CONTAINER_NAME="nginx"

VOLUMES="
html
"

FILES="
docker-compose.yml
Dockerfile
nginx.conf
conf.d/
html
"

if [[ $EUID -ne 0 ]]; then
    echo "This script should be run with root/sudo privileges."
    exit 1
fi

CUR_USER=$(whoami)
LOC="/opt"

mkdir -p $LOC/$CONTAINER_NAME

for file in $FILES; do
    if [ -d "$file" ]; then
        cp -r $file $LOC/$CONTAINER_NAME/$file
    elif [ -f "$file" ]; then
        cp $file $LOC/$CONTAINER_NAME/$file
    fi
done

for vol in $VOLUMES; do
    mkdir -p $LOC/$CONTAINER_NAME/$vol
    chmod -R 777 $LOC/$CONTAINER_NAME/$vol
done

echo "Installed $CONTAINER_NAME to $LOC"
echo "Run 'docker compose up --build' to start"
echo "cd $LOC/$CONTAINER_NAME"