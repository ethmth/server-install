#!/bin/bash

NAME="postgres"

if [[ $EUID -ne 0 ]]; then
    echo "This script should be run with root/sudo privileges."
    exit 1
fi

CUR_USER=$(whoami)

if ! [ -e "../$NAME/docker-compose.yml" ]; then
	echo "Make sure you run this script in the same directory as ../$NAME/docker-compose.yml"
	exit 1
fi

LOC="~/programs"
mkdir -p $LOC

if ! [ -e "$LOC/$NAME" ]; then
mkdir -p $LOC/$NAME
mkdir -p $LOC/$NAME/data
chmod -R 777 $LOC/$NAME/data
fi

cp docker-compose.yml $LOC/$NAME/docker-compose.yml

cd $LOC/$NAME/

echo "Run 'docker compose up --build -d' to run it and 'docker compose stop' to stop it from that directory"
echo "cd $LOC/$NAME"