#!/bin/bash

CONTAINER_NAME="gluetun"

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi

CUR_USER=$(whoami)

if ! [ -e "/home/$CUR_USER/programs/$CONTAINER_NAME/docker-compose.yaml" ]; then
	echo "Make sure you installed gluetun using ./01-gluetun-setup.sh"
	exit 1
fi


cd /home/$CUR_USER/programs/$CONTAINER_NAME
docker compose up --build -d