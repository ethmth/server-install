#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! [ -e "$SCRIPT_DIR/conf.env" ]; then
    echo "Be sure to generate the configuration file $SCRIPT_DIR/conf.env using ./02-config.sh"
    exit 1
fi

source $SCRIPT_DIR/conf.env

DIR="$INSTALLATION_DIR/build/python"
mkdir -p $DIR

wget -O $DIR/python.tar.xz https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tar.xz
cd $DIR
tar -xvf python.tar.xz
DIR_NAME=$(ls $DIR -1 | grep -v "tar.xz")
cd $DIR/$DIR_NAME
./configure
make && sudo make install

