#!/bin/bash

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
    -activate -configure -access -on \
    -restart -agent

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
    -configure -allowAccessFor -allUsers


sudo defaults write /Library/Preferences/com.apple.VNCSettings VNCPassword -data $(echo -n 'password' | openssl md5 -binary | base64)

# sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
#     -status

# sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -off -restart -agent -privs -all -allowAccessFor -allUsers -clientopts -setvncpw -vncpw secret -setvnclegacy -vnclegacy yes

echo "Go to System Preferences -> General -> Sharing -> Remote Management"
echo "Click Computer Settings, VNC viewers may control screen with password."

echo "Then, reboot."

echo "(Note: You may have to reboot multiple times until autologin, VNC, and ssh work)