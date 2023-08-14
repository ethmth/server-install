#!/bin/bash

VERSION="4.1.4"
mkdir -p ~/Downloads/AirMessage

curl -L0 -o ~/Downloads/AirMessage/AirMessage-$VERSION.zip https://github.com/airmessage/airmessage-server/releases/download/v$VERSION/AirMessage-$VERSION.zip

cd ~/Downloads/AirMessage
unzip AirMessage-$VERSION.zip

mv AirMessage.app ~/Desktop/AirMessage.app

echo "Run and configure AirMessage from the Desktop"

echo "=============== INSTALLATION ================="
echo "Install and configure AirMessage from the Desktop"

echo "=============== PERMISSIONS ================="
echo "1. Ensure AirMessage has permission in System Preferences > Security & Privacy > Privacy > Automation"
echo "2. Under System Preferences > Security & Privacy > Privacy > Full Disk Access, add AirMessage"
echo "3. System Preferences > Energy Saver. Change energy settings to prevent shutdown"