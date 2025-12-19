#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update


nix-shell '<home-manager>' -A install

if ! ( cat "$HOME/.profile" | grep -q '. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"' ); then
    echo '. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"' >> "$HOME/.profile"
fi
