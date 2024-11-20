#!/bin/bash

VERSION="1.9.7"

curl -L0 -o ~/Desktop/BlueBubbles-$VERSION.dmg https://github.com/BlueBubblesApp/bluebubbles-server/releases/download/v$VERSION/BlueBubbles-$VERSION.dmg

echo "=============== INSTALLATION ================="
echo "Install and configure BlueBubbles from the Desktop"
echo "Use Dynamic DNS/Reverse Proxy (https://docs.bluebubbles.app/server/advanced/byo-proxy-service-guides/nginx-manual-setup)"

echo "=============== PERMISSIONS ================="
echo "1. Ensure BlueBubbles has Accessibility permission in System Preferences > Privacy & Security -> Accessibility"
echo "2. Under System Preferences > Privacy & Security > Full Disk Access, add BlueBubbles"
# echo "3. System Preferences > Energy Saver. Change energy settings to prevent shutdown"
# echo "4. System Preferences > Desktop & Screen Saver > Screen Saver > Start after: Never"

echo "=============== STARTUP ================="
echo "1. System Preferences > General > Login Items. Include iMessage and BlueBubbles."
# echo "2. System Preferences > Startup Disk. Set startup disk to Docker-OSX"