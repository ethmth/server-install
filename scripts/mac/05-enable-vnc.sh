#!/bin/bash

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
    -activate -configure -access -on \
    -restart -agent

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
    -configure -allowAccessFor -allUsers


sudo defaults write /Library/Preferences/com.apple.VNCSettings VNCPassword -data $(echo -n 'password' | openssl md5 -binary | base64)

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
    -status