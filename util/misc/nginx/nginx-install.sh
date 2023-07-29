#!/bin/bash

CONTAINER_NAME="nginx"

VOLUMES="
http
certs
"

FILES="
docker-compose.yml
Dockerfile
nginx.conf
"

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

CUR_USER=$(whoami)
LOC="/opt"

mkdir -p $LOC/$CONTAINER_NAME

for file in $FILES; do
    cp $file $LOC/$CONTAINER_NAME/$file
done

for vol in $VOLUMES; do
    mkdir $LOC/$CONTAINER_NAME/$vol
    chmod -R 777 $LOC/$CONTAINER_NAME/$vol
done

echo "Installed $CONTAINER_NAME to $LOC"
echo "Run 'docker compose up --build' to start"
echo "cd $LOC/$CONTAINER_NAME"