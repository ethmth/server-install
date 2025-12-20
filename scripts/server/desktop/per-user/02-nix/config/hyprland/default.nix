{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true; 
  wayland.windowManager.hyprland.xwayland.enable = true; 
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
  };
  wayland.windowManager.hyprland.systemd.variables = ["--all"];

  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-hyprland
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  #   config = {
  #     hyprland = {
  #       default = [ "hyprland" "gtk" ];
  #     };
  #   };
  # };

  # Configure systemd user environment for xdg-desktop-portal
  # This ensures systemd can find the portal service files from Nix
  # Using drop-in directory to avoid overwriting entire user.conf
  xdg.configFile."systemd/user.conf".text = ''
    [Manager]
    ManagerEnvironment="XDG_DATA_DIRS=/usr/local/share:/usr/share:${config.home.homeDirectory}/.nix-profile/share"
  '';

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
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

