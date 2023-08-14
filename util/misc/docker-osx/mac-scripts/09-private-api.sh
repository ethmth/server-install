#!/bin/bash

mkdir -p ~/Downloads/MacForge
curl -L0 -o ~/Downloads/MacForge/MacForge.zip https://github.com/w0lfschild/app_updates/raw/master/MacForge1/MacForge.zip
cd ~/Downloads/MacForge
unzip MacForge.zip
mv MacForge.app ~/Desktop/MacForge.app


VERSION="0.0.16"
mkdir -p ~/Downloads/BlueBubbles
curl -L0 -o ~/Downloads/BlueBubbles/BlueBubblesHelper.bundle.MacOS10.zip https://github.com/BlueBubblesApp/bluebubbles-helper/releases/download/$VERSION/BlueBubblesHelper.bundle.MacOS10.zip
cd ~/Downloads/BlueBubbles
unzip BlueBubblesHelper.bundle.MacOS10.zip
mv BlueBubblesHelper.bundle ~/Desktop/BlueBubblesHelper.bundle

echo "Password is alpine"
sudo mkdir -p "/Library/Application Support/MacEnhance/Plugins"
# mv "~/Desktop/BlueBubblesHelper.bundle" "/Library/Application Support/MacEnhance/Plugins/BlueBubblesHelper.bundle"

echo "Run MacForge from the Desktop"
echo "Drag BlueBubblesHelper.bundle into the 'Manage Plug-ins' page/tab"
echo "Confirm that the BlueBubblesHelper plugin is toggled to library, and not user, within MacForge (the icon should show 2 people, not 1 person)"
echo "Turn on Private API switch in the BlueBubbles Server settings."
echo "Restart."