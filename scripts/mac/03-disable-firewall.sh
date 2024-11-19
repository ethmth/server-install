#!/bin/bash

sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off

sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.alf.agent.plist

sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
