{ config, pkgs, ... }:

let
  wallpaperFile = "${config.home.homeDirectory}/Pictures/Wallpapers/wallpaper.png";
in

{
  # Create hyprpaper config file
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${wallpaperFile}
    wallpaper = , ${wallpaperFile}
  '';
}

