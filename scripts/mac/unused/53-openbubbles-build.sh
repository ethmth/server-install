#!/bin/bash

cd ~/Downloads
git clone https://github.com/OpenBubbles/Mac-Hardware-Info.git
cd Mac-Hardware-Info

xcodebuild -scheme "Mac Hardware Info" -project "Mac Hardware Info.xcodeproj" -configuration Release build

BUILD_DIR=$(find ~/Library/Developer/Xcode/DerivedData -type d -name "Mac_Hardware_Info*" | head -1)
BUILD_DIR="$BUILD_DIR/Build/Products/Release"

mkdir -p /tmp/MacHardwareInfo_DMG
cp -R "$BUILD_DIR/Mac Hardware Info.app" /tmp/MacHardwareInfo_DMG/

mkdir -p "~/Downloads/Mac Hardware Info.app"
cp -R "$BUILD_DIR/Mac Hardware Info.app" "$HOME/Downloads/Mac Hardware Info.app"

hdiutil create -volname "Mac Hardware Info" \
  -srcfolder /tmp/MacHardwareInfo_DMG \
  -ov -format UDZO "$HOME/Downloads/MacHardwareInfo.dmg"

echo "MacHardwareInfo.dmg and Mac Hardware Info.app saved to Downloads. Install/run it from there."