{ pkgs, ... }:

{
  home.packages = with pkgs; [
    foot
    fuzzel
    wlogout
    hyprpaper
    grimblast
    hyprpicker
  ];

  imports = [
    ./hyprland/default.nix
    ./fuzzel/default.nix
    ./wlogout/default.nix
    ./foot/default.nix
    ./dunst.nix
    ./waybar.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];
}
