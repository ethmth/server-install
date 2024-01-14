#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

DIR="$(cd "$(dirname "$0")" && pwd)"

cp $DIR/conf.env.example $DIR/conf.env

echo "Edit the environment configuration file. Then run the next script"
echo "vim $DIR/.conf.env"
vim $DIR/conf.env
