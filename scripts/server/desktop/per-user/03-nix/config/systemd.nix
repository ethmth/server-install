{ config, pkgs, ... }:

let
  nixProfileDir = "${config.home.homeDirectory}/.nix-profile/share";
  ramDirs = {
    "${config.home.homeDirectory}/.cache/thumbnails" = "512M";
    "${config.home.homeDirectory}/.local/share/recently-used.xbel" = "1M"; # make this a directory to essentially disable it.
  };
in
{
  # You have to explicitly add the nix profile directory to the systemd manager environment
  # so that systemd can find the portal service files from Nix
  systemd.user.settings.Manager.ManagerEnvironment = {
    "XDG_DATA_DIRS" = "${nixProfileDir}:$XDG_DATA_DIRS";
  };


  # systemd.user.tmpfiles.rules =
  #   map (dir: "d ${dir} 0700 - - -")
  #     (builtins.attrNames ramDirs);

  systemd.user.mounts =
    builtins.listToAttrs
      (map (dir: {
        name = builtins.replaceStrings [ "/" "-" ] [ "-" "\\x2d" ] (builtins.substring 1 (builtins.stringLength dir) dir);
        value = {
          Unit.Description = "Ephemeral runtime directory for ${dir}";
          Mount = {
            What = "%t${dir}";
            Where = dir;
            Type = "bind";
            Options = "rbind,rw";
          };
          Install.WantedBy = [ "default.target" ];
        };
      }) (builtins.attrNames ramDirs));
}

