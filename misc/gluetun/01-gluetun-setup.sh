#!/bin/bash

CONTAINER_NAME="gluetun"

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi

CUR_USER=$(whoami)

mkdir -p /home/$CUR_USER/programs/$CONTAINER_NAME

if ! [ -e "../$CONTAINER_NAME/docker-compose.yml" ]; then
	echo "Make sure you run this script in the same directory as ../$CONTAINER_NAME/docker-compose.yaml"
	exit 1
fi

PROVIDER=$(cat providers.txt | fzf --prompt="Select your vpn provider")

if [ "$PROVIDER" == "" ]; then
	echo "No provider selected"
	exit 1
fi

read -p "Please enter your username (will be echoed): " username
echo -n "Please enter your password (will be stored): "
read -s password
echo

cp docker-compose.yml /home/$CUR_USER/programs/$CONTAINER_NAME/docker-compose.yaml

sed -i "s/SERVICE_PROVIDER_HERE/$PROVIDER/g" /home/$CUR_USER/programs/$CONTAINER_NAME/docker-compose.yaml
sed -i "s|PATH_HERE|/home/$CUR_USER/programs/$CONTAINER_NAME|g" /home/$CUR_USER/programs/$CONTAINER_NAME/docker-compose.yaml
sed -i "s/OVPN_USER_HERE/$username/g" /home/$CUR_USER/programs/$CONTAINER_NAME/docker-compose.yaml
sed -i "s/OVPN_PASSWORD_HERE/$password/g" /home/$CUR_USER/programs/$CONTAINER_NAME/docker-compose.yaml

echo "Installed $CONTAINER_NAME to /home/$CUR_USER/programs"

echo "NOTE: If your password has Special characters, it may not be set correctly. Edit /home/$CUR_USER/programs/$CONTAINER_NAME/docker-compose.yml to fix it"