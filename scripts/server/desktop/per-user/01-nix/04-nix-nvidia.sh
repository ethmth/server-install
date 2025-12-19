#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should NOT be run with root/sudo privileges."
        exit 1
fi

ARCH="x86_64"
DRIVER_VERSION=$(nvidia-smi --version | grep "DRIVER" | cut -d ':' -f2 | xargs)

if ! [[ "$DRIVER_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "NVIDIA driver version not detected, doing nothing"
  echo "If using an NVIDIA GPU, ensure the drivers are installed and nvidia-smi works"
  echo "If not using an NVIDIA GPU, skip this script, but make sure to run home-manager switch once hyprland.nix is imported before moving on"
  exit 1
fi

echo "Driver Version: $DRIVER_VERSION"

echo "Fetching https://download.nvidia.com/XFree86/Linux-$ARCH/$DRIVER_VERSION/NVIDIA-Linux-$ARCH-$DRIVER_VERSION.run"
HASH_OUTPUT=$(nix --extra-experimental-features nix-command store prefetch-file --json "https://download.nvidia.com/XFree86/Linux-$ARCH/$DRIVER_VERSION/NVIDIA-Linux-$ARCH-$DRIVER_VERSION.run")

HASH=$(echo "$HASH_OUTPUT" | jq .hash | xargs)
echo "Hash: $HASH"

echo "{
  # Don't touch this file, it's generated automatically by 04-nix-nvidia.sh
  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = \"$DRIVER_VERSION\";
    sha256 = \"$HASH\";
  };
}" > "$HOME/.config/home-manager/nvidia.nix"

echo "Add ./nvidia.nix to home.nix's imports, then run home-manager switch"
