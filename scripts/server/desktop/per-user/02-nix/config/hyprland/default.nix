{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true; 
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config = {
      hyprland = {
        default = [ "hyprland" "gtk" ];
      };
    };
  };

  # Configure systemd user environment for xdg-desktop-portal
  # This ensures systemd can find the portal service files from Nix
  # Using drop-in directory to avoid overwriting entire user.conf
  xdg.configFile."systemd/user.conf.d/10-xdg-data-dirs.conf".text = ''
    [Manager]
    ManagerEnvironment="XDG_DATA_DIRS=/usr/local/share:/usr/share:${config.home.homeDirectory}/.local/state/nix/profile/share:/nix/var/nix/profiles/default/share"
  '';

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

