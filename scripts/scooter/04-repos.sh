#!/bin/bash

#GATT_REPO="https://github.com/ethmth/bluez-gatt-server.git"
SCOOTER_REPO="https://github.com/ethmth/e-scooter.git"

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

DIR="$(cd "$(dirname "$0")" && pwd)"

if ! [ -e "$DIR/conf.env" ]; then
	echo "Be sure to generate the configuration file $DIR/conf.env using ./03-config.sh"
	exit 1
fi

source $DIR/conf.env

mkdir -p $INSTALLATION_DIR

cd $INSTALLATION_DIR
#git clone $GATT_REPO bluez-gatt-server
git clone $SCOOTER_REPO e-scooter

cd $INSTALLATION_DIR/e-scooter
./gen-types.sh

#cd $INSTALLATION_DIR/bluez-gatt-server
#git checkout ethmth


