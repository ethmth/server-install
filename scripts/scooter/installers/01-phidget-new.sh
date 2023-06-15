#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
		echo "This script should not be run with root/sudo privileges."
			exit 1
fi
CUR_USER=$(whoami)

mkdir /tmp/phidget-temp
wget -O /tmp/phidget-temp/libphidget.tar.gz https://www.phidgets.com/downloads/phidget22/libraries/linux/libphidget22.tar.gz
cd /tmp/phidget-temp
tar -xvf libphidget.tar.gz
DIR_NAME=$(ls /tmp/phidget-temp/ -1 | grep -v "tar.gz")

cd /tmp/phidget-temp/$DIR_NAME
bash /tmp/phidget-temp/$DIR_NAME/configure
make
sudo make install

# Automatic:
pip3 install Phidget22

# DONT RUN THIS AS SUDO ON ARCH:
# Manual:
#wget -O /tmp/phidget-temp/Phidget22Python.zip https://www.phidgets.com/downloads/phidget22/libraries/any/Phidget22Python.zip
#cd /tmp/phidget-temp
#unzip Phidget22Python.zip
#DIR_NAME=$(ls /tmp/phidget-temp/ -1 | grep "Python" | grep -v "zip")
#cd /tmp/phidget-temp/$DIR_NAME
#sudo -k python3 /tmp/phidget-temp/$DIR_NAME/setup.py install

wget -O /tmp/phidget-temp/libphidgetextra.tar.gz https://www.phidgets.com/downloads/phidget22/libraries/linux/libphidget22extra.tar.gz
cd /tmp/phidget-temp
tar -xvf libphidgetextra.tar.gz
DIR_NAME=$(ls /tmp/phidget-temp/ -1 | grep "extra" | grep -v "tar.gz")
cd /tmp/phidget-temp/$DIR_NAME
bash /tmp/phidget-temp/$DIR_NAME/configure
make
sudo make install

wget -O /tmp/phidget-temp/phidgetnetworkserver.tar.gz https://www.phidgets.com/downloads/phidget22/servers/linux/phidget22networkserver.tar.gz
cd /tmp/phidget-temp
tar -xvf phidgetnetworkserver.tar.gz
DIR_NAME=$(ls /tmp/phidget-temp/ -1 | grep "networkserver" | grep -v "tar.gz")
cd /tmp/phidget-temp/$DIR_NAME
bash /tmp/phidget-temp/$DIR_NAME/configure
make
sudo make install

wget -O /tmp/phidget-temp/phidgetadmin.tar.gz https://www.phidgets.com/downloads/phidget22/tools/linux/phidget22admin.tar.gz
cd /tmp/phidget-temp
tar -xvf phidgetadmin.tar.gz
DIR_NAME=$(ls /tmp/phidget-temp/ -1 | grep "admin" | grep -v "tar.gz")
cd /tmp/phidget-temp/$DIR_NAME
bash /tmp/phidget-temp/$DIR_NAME/configure
make
sudo make install

