{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprpaper"
      "waybar"
      "dunst"
    ];
  };
}

