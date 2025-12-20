{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true; 
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  imports = [
    ./env.nix
    ./exec.nix
    ./binds.nix
    ./input.nix
    ./general.nix
    ./windowrules.nix
    ./monitors.nix
  ];
}

