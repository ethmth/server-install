#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

if ! [ -f "wrappedhl" ]; then
	echo "wrappedhl not found"
fi

if ! [ -f "wrappedhl.service" ]; then
	echo "wrappedhl.service not found"
fi

mkdir -p "$HOME/.local/bin"

cp "wrappedhl" "$HOME/.local/bin/wrappedhl"
chmod 755 "$HOME/.local/bin/wrappedhl"

mkdir -p "$HOME/.config/systemd/user"
cp "wrappedhl.service" "$HOME/.config/systemd/user/wrappedhl.service"
chmod 777 "$HOME/.config/systemd/user/wrappedhl.service"

systemctl --user enable wrappedhl.service



