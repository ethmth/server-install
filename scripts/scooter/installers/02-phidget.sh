#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! [ -e "$SCRIPT_DIR/../conf.env" ]; then
	echo "Be sure to generate the configuration file $SCRIPT_DIR/conf.env using ../03-config.sh"
	exit 1
fi

source $SCRIPT_DIR/../conf.env

DIR="$INSTALLATION_DIR/build/phidget"
mkdir -p $DIR

wget -O $DIR/libphidget.tar.gz https://www.phidgets.com/downloads/phidget22/libraries/linux/libphidget22.tar.gz
cd $DIR
tar -xvf libphidget.tar.gz
DIR_NAME=$(ls $DIR -1 | grep -v "tar.gz")
cd $DIR/$DIR_NAME
bash $DIR/$DIR_NAME/configure
make
sudo make install

wget -O $DIR/libphidgetextra.tar.gz https://www.phidgets.com/downloads/phidget22/libraries/linux/libphidget22extra.tar.gz
cd $DIR
tar -xvf libphidgetextra.tar.gz
DIR_NAME=$(ls $DIR -1 | grep "extra" | grep -v "tar.gz")
cd $DIR/$DIR_NAME
bash $DIR/$DIR_NAME/configure
make
sudo make install

wget -O $DIR/phidgetnetworkserver.tar.gz https://www.phidgets.com/downloads/phidget22/servers/linux/phidget22networkserver.tar.gz
cd $DIR
tar -xvf phidgetnetworkserver.tar.gz
DIR_NAME=$(ls $DIR -1 | grep "networkserver" | grep -v "tar.gz")
cd $DIR/$DIR_NAME
bash $DIR/$DIR_NAME/configure
make
sudo make install

wget -O $DIR/phidgetadmin.tar.gz https://www.phidgets.com/downloads/phidget22/tools/linux/phidget22admin.tar.gz
cd $DIR
tar -xvf phidgetadmin.tar.gz
DIR_NAME=$(ls $DIR -1 | grep "admin" | grep -v "tar.gz")
cd $DIR/$DIR_NAME
bash $DIR/$DIR_NAME/configure
make
sudo make install

$PYTHON_COMMAND -m pip install Phidget22
