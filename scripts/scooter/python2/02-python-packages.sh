#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

DIR="$(cd "$(dirname "$0")" && pwd)"

#if ! [ -e "$DIR/conf.env" ]; then
#	echo "Be sure to generate the configuration file $DIR/conf.env using ./03-config.sh"
#	exit 1
#fi
#
#source $DIR/conf.env

PYTHON_COMMAND="python2"

cd $DIR
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
$PYTHON_COMMAND get-pip.py
$PYTHON_COMMAND -m pip --version

packages="
paho-mqtt
pandas
pytest
"
packages=${packages//$'\n'/ }
packages=$(echo "$packages" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

$PYTHON_COMMAND -m pip install --upgrade pip
$PYTHON_COMMAND -m pip install $packages
