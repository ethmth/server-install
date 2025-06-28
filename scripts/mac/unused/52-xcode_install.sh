#!/bin/bash

sudo mv Xcode.app /Applications/Xcode.app

sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

xcodebuild -version

sudo xcodebuild -license

sudo xcodebuild -runFirstLaunch