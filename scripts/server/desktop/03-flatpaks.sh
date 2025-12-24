#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpaks="
org.gnome.Brasero
com.vscodium.codium
com.github.tchx84.Flatseal
com.obsproject.Studio
com.brave.Browser
io.gitlab.librewolf-community
net.mullvad.MullvadBrowser
org.chromium.Chromium
com.google.Chrome
org.torproject.torbrowser-launcher
com.usebruno.Bruno
io.dbeaver.DBeaverCommunity
org.cryptomator.Cryptomator
org.prismlauncher.PrismLauncher
com.valvesoftware.Steam
"

flatpaks=${flatpaks//$'\n'/ }
flatpaks=$(echo "$flatpaks" | tr -s ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
flatpak install --noninteractive flathub $flatpaks
