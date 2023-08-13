#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

username="user"
password="alpine"

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}")
cd $SCRIPT_RELATIVE_DIR
ABSOLUTE_PATH=$(pwd)

CUR_USER=$(whoami)

sshpass -p "$password" scp -r -o StrictHostKeyChecking=no -P 50922 $ABSOLUTE_PATH/mac-scripts $username@127.0.0.1:/Users/$username/Downloads

echo "If the scp command was successful, you should find mac-scripts/ in your Downloads/ directory on Mac."
echo "Start running the scripts"