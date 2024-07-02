#!/bin/bash

NAME="postgres"

if ! [[ $EUID -ne 0 ]]; then
    echo "This script should not be run with root/sudo privileges."
    exit 1
fi

CUR_USER=$(whoami)

if ! [ -e "../$NAME/docker-compose.yml" ]; then
	echo "Make sure you run this script in the same directory as ../$NAME/docker-compose.yml"
	exit 1
fi

# SPECIFIC CHECKS
if mountpoint -q /mnt/cryptdata; then
    if ! [ -d "/mnt/cryptdata/encrypted" ]; then
	    echo "/mnt/cryptdata/encrypted does not exist."
        exit 1
    fi
else
    echo "/mnt/cryptdata is not mounted."
    exit 1
fi

LOC="$HOME"

if ! [ -d "$LOC" ]; then
    echo "Your location is not available. Is the disk mounted? Do you have access?"
	exit 1
fi

LOC="$LOC/programs"
mkdir -p $LOC

if ! [ -e "$LOC/$NAME" ]; then
    mkdir -p $LOC/$NAME
fi

if [ -d "/mnt/cryptdata/encrypted" ]; then
    sudo mkdir -p /mnt/cryptdata/encrypted/postgres/data
    sudo chmod -R +777 /mnt/cryptdata/encrypted/postgres/data
fi

cp docker-compose.yml $LOC/$NAME/docker-compose.yml

cd $LOC/$NAME/

echo "Run 'docker-compose up --build -d' to run it and 'docker-compose stop' to stop it from that directory"
echo "cd $LOC/$NAME"