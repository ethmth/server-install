{ config, pkgs, ... }:

{
  # Manage XFCE4 helpers.rc file
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=foot
    FileManager=thunar
  '';

  # # Clear Thunar recently used files and make immutable
  # xdg.dataFile."recently-used.xbel".text = ''
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <xbel version="1.0"
  #         xmlns:bookmark="http://www.freedesktop.org/standards/desktop-bookmarks"
  #         xmlns:mime="http://www.freedesktop.org/standards/shared-mime-info"
  #   ></xbel>
  # '';

  # # Clear Thunar recently used files and make immutable
  # home.file.".local/share/recently-used.xbel".text = ''
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <xbel version="1.0"
  #         xmlns:bookmark="http://www.freedesktop.org/standards/desktop-bookmarks"
  #         xmlns:mime="http://www.freedesktop.org/standards/shared-mime-info"
  #   ></xbel>
  # '';
}

