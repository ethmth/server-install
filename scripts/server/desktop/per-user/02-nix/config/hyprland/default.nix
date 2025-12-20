{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true; 
  wayland.windowManager.hyprland.xwayland.enable = true; 
  wayland.windowManager.hyprland.systemd.variables = ["--all"];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      hyprland = {
        default = [ "hyprland" "gtk" ];
      };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 14;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
  };

  imports = [
    ./env.nix
    ./exec.nix
    ./binds.nix
    ./input.nix
    ./general.nix
    ./windowrules.nix
    ./monitors.nix
    ./plugins.nix
  ];
}

