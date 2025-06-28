#!/bin/bash

echo "YOU NEED ETHERNET WORKING (specifically the en0 interface?) FOR THIS APP TO RUN"
echo "I WAS ABLE TO GET IT WORKING BY HAVING ETHERNET PLUGGED IN WHILE I BOOTED UP"
echo "You can also run ./MacAddressDebug.swift to check this. Your IOEthernetInterface must be marked as IOPrimaryInterface (1)"


curl -L -o ~/Downloads/Mac.Hardware.Info.zip https://github.com/OpenBubbles/Mac-Hardware-Info/releases/latest/download/Mac.Hardware.Info.zip
cd ~/Downloads
ditto -x -k Mac.Hardware.Info.zip .

echo "Mac Hardware Info.app saved to Downloads. Run it from there. Remember to backup your code!"

# mv "Mac Hardware Info.app" /Applications/

# echo "Install the full XCode from the App Store"
# echo "Download from this URL using Safari (for some reason wget/curl then unzip/ditto won't work):"
# echo "https://github.com/OpenBubbles/Mac-Hardware-Info/releases/latest/download/Mac.Hardware.Info.zip"