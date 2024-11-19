#!/bin/bash

# brew install docker

CUR_USER=$(id -un)

cd ~/Downloads
wget "https://github.com/x74353/Amphetamine-Enhancer/raw/master/Releases/Current/Amphetamine%20Enhancer.dmg"
sudo hdiutil attach "Amphetamine Enhancer.dmg"
# sudo "/Volumes/Amphetamine Enhancer/Amphetamine Enhancer.app/Contents/MacOS/Amphetamine Enhancer"
sudo cp -R "/Volumes/Amphetamine Enhancer/Amphetamine Enhancer.app" /Applications
sudo hdiutil detach "/Volumes/Amphetamine Enhancer"

echo "Open 'Amphetamine Enhancer' and install 'Closed-Display Mode Fail-Safe'"