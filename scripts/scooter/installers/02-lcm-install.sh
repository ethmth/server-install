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

DIR="$INSTALLATION_DIR/build/lcm"
mkdir -p $DIR

mkdir $DIR
wget -O $DIR/lcm.zip https://github.com/lcm-proj/lcm/archive/refs/tags/v1.5.0.zip
cd $DIR
unzip lcm.zip
DIR_NAME=$(ls $DIR -1 | grep -v "zip")

mkdir $DIR/$DIR_NAME/build
cd $DIR/$DIR_NAME/build
cmake ..
make
sudo make install

cd $DIR/$DIR_NAME/lcm-python
sudo $PYTHON_COMMAND setup.py install
