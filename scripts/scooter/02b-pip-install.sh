#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

DIR="$(cd "$(dirname "$0")" && pwd)"

if ! [ -e "$DIR/conf.env" ]; then
    echo "Be sure to generate the configuration file $DIR/conf.env using ./02-config.sh"
    exit 1
fi

source $DIR/conf.env

curl https://bootstrap.pypa.io/pip/3.6/get-pip.py -o get-pip.py

$PYTHON_COMMAND get-pip.py

$PYTHON_COMMAND -m pip --version

$PYTHON_COMMAND -m pip install --upgrade pip

#rm get-pip.py


