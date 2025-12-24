{ config, pkgs, ... }:

let
  nixProfileDir = "${config.home.homeDirectory}/.nix-profile/share";
in
{
  # You have to explicitly add the nix profile directory to the systemd manager environment
  # so that systemd can find the portal service files from Nix
  systemd.user.settings.Manager.ManagerEnvironment = {
    "XDG_DATA_DIRS" = "${nixProfileDir}:$XDG_DATA_DIRS";
  };
}

