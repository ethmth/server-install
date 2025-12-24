{ config, pkgs, ... }:

{
  # Manage XFCE4 helpers.rc file
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=foot
    FileManager=thunar
  '';

  # Create systemd service to ensure the directory exists before Home Manager tries to manage it
  systemd.user.services."create-recently-used-xbel" = {
    Service.Description = "Create recently-used.xbel directory";
    Service.Type = "oneshot";
    Service.ExecStart = ''
      ${pkgs.bash}/bin/bash -c 'rm -rf "${config.home.homeDirectory}/.local/share/recently-used.xbel" && mkdir -p "${config.home.homeDirectory}/.local/share/recently-used.xbel" && chmod 755 "${config.home.homeDirectory}/.local/share/recently-used.xbel"'
    '';
    Service.RemainAfterExit = true;
    Install.WantedBy = [ "default.target" ];
  };
}
