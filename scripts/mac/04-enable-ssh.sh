#!/bin/bash

echo "If you haven't already, give Terminal (Applications -> Utilities -> Terminal) Full Disk Access"

sudo systemsetup -setremotelogin on
sudo systemsetup -getremotelogin


ifconfig | grep "inet " | grep -v 127.0.0.1

echo "Enable Remote Login with Full Disk Access for All Users in System Preferences -> General -> Sharing -> Remote Login"