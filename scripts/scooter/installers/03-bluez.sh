#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

BLUEZ_VERSION="5.66"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! [ -e "$SCRIPT_DIR/../conf.env" ]; then
	echo "Be sure to generate the configuration file $SCRIPT_DIR/conf.env using ../03-config.sh"
	exit 1
fi

source $SCRIPT_DIR/../conf.env

DIR="$INSTALLATION_DIR/build/bluez"
mkdir -p $DIR

wget -O $DIR/bluez.tar.xz http://www.kernel.org/pub/linux/bluetooth/bluez-$BLUEZ_VERSION.tar.xz
cd $DIR
tar -xvf bluez.tar.xz
DIRNAME=$(ls -1 $DIR | grep -v "tar.xz")
cd $DIR/$DIRNAME
./configure
make
sudo make install
