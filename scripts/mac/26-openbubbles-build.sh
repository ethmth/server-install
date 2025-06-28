#!/bin/bash

cd ~/Downloads
git clone https://github.com/OpenBubbles/Mac-Hardware-Info.git
cd Mac-Hardware-Info

xcodebuild -scheme "Mac Hardware Info" -project "Mac Hardware Info.xcodeproj" -configuration Release build

# cp "build/Release/Mac Hardware Info.app" "~/Downloads/Mac Hardware Info.app"

# cp "~/Library/Developer/Xcode/DerivedData/Mac_Hardware_Info*/Build/Products/Release/Mac Hardware Info.app" "~/Downloads/Mac Hardware Info.app"

BUILD_DIR=$(find ~/Library/Developer/Xcode/DerivedData -type d -name "Mac_Hardware_Info*" | head -1)
# cp -R "$BUILD_DIR/Build/Products/Release/Mac Hardware Info.app" "~/Downloads/"

BUILD_DIR="$BUILD_DIR/Build/Products/Release"



# hdiutil create -volname "Mac Hardware Info" -srcfolder "$BUILD_DIR/Build/Products/Release" -ov -format UDZO "~/Downloads/MacHardwareInfo.dmg"

mkdir -p /tmp/MacHardwareInfo_DMG
cp -R "$BUILD_DIR/Mac Hardware Info.app" /tmp/MacHardwareInfo_DMG/

hdiutil create -volname "Mac Hardware Info" \
  -srcfolder /tmp/MacHardwareInfo_DMG \
  -ov -format UDZO "$HOME/Downloads/MacHardwareInfo.dmg"

echo "MacHardwareInfo.dmg saved to Downloads. Install it from there."