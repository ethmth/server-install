{ config, pkgs, ... }:

let
  nixProfileDir = "${config.home.homeDirectory}/.nix-profile/share";
  ramDirs = {
    ".cache/thumbnails" = "512M";
    ".local/share/recently-used.xbel" = "1M"; # make this a directory to essentially disable it.
  };
in
{
  # You have to explicitly add the nix profile directory to the systemd manager environment
  # so that systemd can find the portal service files from Nix
  systemd.user.settings.Manager.ManagerEnvironment = {
    "XDG_DATA_DIRS" = "${nixProfileDir}:$XDG_DATA_DIRS";
  };


  systemd.user.tmpfiles.rules =
    map (dir: "d %h/${dir} 0700 - - -")
      (builtins.attrNames ramDirs);

  systemd.user.mounts =
    builtins.listToAttrs
      (map (dir: {
        name = builtins.replaceStrings [ "/" "." ] [ "-" "-" ] (builtins.substring 1 (builtins.stringLength dir) dir);
        value = {
          Unit.Description = "Tmpfs mount for %h/${dir}";
          Mount = {
            What = "tmpfs";
            Where = "%h/${dir}";
            Type = "tmpfs";
            Options = "mode=0700,size=${ramDirs.${dir}}";
          };
          Install.WantedBy = [ "default.target" ];
        };
      }) (builtins.attrNames ramDirs));
}

