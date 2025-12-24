{ config, pkgs, ... }:

{
  # Manage XFCE4 helpers.rc file
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=foot
    FileManager=thunar
  '';

  home.file.".local/share/recently-used.xbel/.keep" = {
    text = "";
  };
}
