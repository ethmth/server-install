{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprpaper"
      "waybar"
      "dunst"
      "bash -c 'sleep 60 && QT_SCALE_FACTOR=1 QT_QPA_PLATFORM=xcb megasync'"
    ];
  };
}

