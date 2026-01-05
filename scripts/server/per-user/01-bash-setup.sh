#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

# This should already be included in .profile/.bash_profile
if ! ( cat "$HOME/.bashrc" | grep -q "PATH=\$PATH:$HOME/.local/bin" ); then
echo "PATH=\$PATH:$HOME/.local/bin" >> "$HOME/.bashrc"
fi
