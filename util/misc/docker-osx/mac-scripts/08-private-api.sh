#!/bin/bash

mkdir -p ~/Downloads/MacForge

curl -L0 -o ~/Downloads/MacForge/MacForge.zip https://github.com/w0lfschild/app_updates/raw/master/MacForge1/MacForge.zip

cd ~/Downloads/MacForge
unzip MacForge.zip

# mv AirMessage.app ~/Desktop/AirMessage.app

echo "=============== INSTALLATION ================="
echo "Install and configure BlueBubbles from the Desktop"
echo "Use Dynamic DNS"

echo "=============== PERMISSIONS ================="
echo "1. Ensure BlueBubbles has Accessibility permission in System Preferences > Security & Privacy > Privacy > Accessibility"
echo "2. Under System Preferences > Security & Privacy > Privacy > Full Disk Access, add BlueBubbles"
echo "3. System Preferences > Energy Saver. Change energy settings to prevent shutdown"

echo "=============== STARTUP ================="
echo "1. System Preferences > Users & Groups > user > Login Items. Include iMessage, BlueBubbles, and AirMessage."
