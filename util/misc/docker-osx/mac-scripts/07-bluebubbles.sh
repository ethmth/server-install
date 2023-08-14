#!/bin/bash


VERSION="1.7.3"
# mkdir -p ~/Downloads/BlueBubbles

curl -L0 -o ~/Desktop/BlueBubbles-$VERSION.dmg https://github.com/BlueBubblesApp/bluebubbles-server/releases/download/v$VERSION/BlueBubbles-$VERSION.dmg

# cd ~/Downloads/BlueBubbles

# mv AirMessage.app ~/Desktop/AirMessage.app

echo "Install and configure BlueBubbles from the Desktop"
echo "Use Dynamic DNS"

echo "1. Ensure BlueBubbles has Accessibility permission in System Preferences > Security & Privacy > Privacy > Accessibility"
echo "2. Under System Preferences > Security & Privacy > Privacy > Full Disk Access, add BlueBubbles"
echo "3. System Preferences > Energy Saver. Change energy settings to prevent shutdown"