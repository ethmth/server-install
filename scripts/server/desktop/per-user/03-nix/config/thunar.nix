{ config, pkgs, ... }:

{
  # xdg.mimeApps.enable = true;
  # xdg.mimeApps.assoc = {
  #   "application/x-shellscript" = "foot.desktop";
  #   "application/x-terminal-emulator" = "foot.desktop";
  # };

  # Manage XFCE4 helpers.rc file
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=foot
    FileManager=thunar
  '';
}

