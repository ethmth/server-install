#!/bin/bash

echo "The password is alpine"

sudo defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true

echo "Reboot, then log into iMessage"