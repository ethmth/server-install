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
rm -rf $DIR
mkdir -p $DIR

wget -O $DIR/libphidget.tar.gz https://www.phidgets.com/downloads/phidget22/libraries/linux/libphidget22.tar.gz
cd $DIR
tar -xvf libphidget.tar.gz
DIR_NAME=$(ls $DIR -1 | grep -v "tar.gz")
cd $DIR/$DIR_NAME
./configure
make
sudo make install

wget -O $DIR/libphidgetextra.tar.gz https://www.phidgets.com/downloads/phidget22/libraries/linux/libphidget22extra.tar.gz
cd $DIR
tar -xvf libphidgetextra.tar.gz
DIR_NAME=$(ls $DIR -1 | grep "extra" | grep -v "tar.gz")
cd $DIR/$DIR_NAME
./configure
make
sudo make install

wget -O $DIR/phidgetnetworkserver.tar.gz https://www.phidgets.com/downloads/phidget22/servers/linux/phidget22networkserver.tar.gz
cd $DIR
tar -xvf phidgetnetworkserver.tar.gz
DIR_NAME=$(ls $DIR -1 | grep "networkserver" | grep -v "tar.gz")
cd $DIR/$DIR_NAME
./configure
make
sudo make install

wget -O $DIR/phidgetadmin.tar.gz https://www.phidgets.com/downloads/phidget22/tools/linux/phidget22admin.tar.gz
cd $DIR
tar -xvf phidgetadmin.tar.gz
DIR_NAME=$(ls $DIR -1 | grep "admin" | grep -v "tar.gz")
cd $DIR/$DIR_NAME
./configure
make
sudo make install

sudo bash -c 'echo "SUBSYSTEMS==\"usb\", ACTION==\"add\", ATTRS{idVendor}==\"06c2\", ATTRS{idProduct}==\"00[3-a][0-f]\", MODE=\"666\"" > /etc/udev/rules.d/99-libphidget22.rules'

#$PYTHON_COMMAND -m pip install Phidget22
#wget -O $DIR/Phidget22Python.zip https://www.phidgets.com/downloads/phidget22/libraries/any/Phidget22Python.zip
#cd $DIR
#unzip Phidget22Python.zip
#DIR_NAME=$(ls $DIR -1 | grep "Python" | grep -v "zip")
#cd $DIR/$DIR_NAME
#sudo $PYTHON_COMMAND setup.py install
