#!/bin/bash

# brew install docker

CUR_USER=$(id -un)

cd ~/Downloads
wget https://desktop.docker.com/mac/main/amd64/Docker.dmg
sudo hdiutil attach Docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --user="$CUR_USER"
sudo hdiutil detach /Volumes/Docker

echo "System Settings -> General -> Login Items"
# echo "Add Docker to 'Open at Login'"
echo "Make sure Docker is 'Allowed at Login'"

echo "======================================="
echo "In the Docker app, go to settings and select: Start docker when you sign in to your computer."
echo "Additionally, go to Docker -> Settings -> Resources -> File Sharing and add '/opt' (may need to restart Docker Desktop a few times to take effect)"
