#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi
systemctl --user disable wrappedhl.service
rm "$HOME/.config/systemd/user/wrappedhl.service"
rm "$HOME/.local/bin/wrappedhl"




