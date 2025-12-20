{ config, pkgs, ... }:

{
  # Fuzzel configuration
  home.file.".config/fuzzel/config".source = ./config;

  # Fuzzel powermenu script
  home.file.".config/fuzzel/powermenu.sh".source = ./powermenu.sh;
  home.file.".config/fuzzel/powermenu.sh".executable = true;
}
