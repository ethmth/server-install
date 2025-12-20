{ config, pkgs, ... }:

{
  # Fuzzel configuration
  home.file.".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;
}
