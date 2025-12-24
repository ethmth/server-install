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

  # create systemd user services to symlink ephemeral directories
  systemd.user.services = builtins.listToAttrs
    (map (dir: {
      name = "ephemeral-" + builtins.replaceStrings [ "/" "-" ] [ "-" "\\x2d" ] (builtins.substring 1 (builtins.stringLength dir) dir);
      value = {
        Service.Description = "Symlink ephemeral runtime directory for ${dir}";
        Service.Type = "oneshot";
        Service.ExecStart = ''
          ${pkgs.bash}/bin/bash -c 'rm -rf "${dir}"; mkdir -p "$XDG_RUNTIME_DIR/ephemeral${dir}"; ln -s "$XDG_RUNTIME_DIR/ephemeral${dir}" "${dir}"'
        '';
        Service.RemainAfterExit = true;
        Install.WantedBy = [ "default.target" ];
      };
    }) (builtins.attrNames ramDirs));
}

