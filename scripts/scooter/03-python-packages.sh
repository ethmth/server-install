#!/bin/bash

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

packages="
paho-mqtt
pandas
pytest
obd
pygatt
gpiozero
poetry
flit
setuptools
flask
flask-socketio
requests
websocket-client
"
packages=${packages//$'\n'/ }
packages=$(echo "$packages" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

$PYTHON_COMMAND -m pip install --upgrade pip
$PYTHON_COMMAND -m pip install $packages
