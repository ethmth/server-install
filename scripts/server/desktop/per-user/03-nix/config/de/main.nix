{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    foot
    fuzzel
    wlogout
    hyprpaper
    grimblast
    hyprpicker
    cascadia-code
    hyprcursor
    hyprpolkitagent
    hyprsunset
  ];

  imports = [
    ./hyprland/default.nix
    ./awesome/awesome.nix  # AwesomeWM configuration
    ./fuzzel/default.nix
    ./wlogout/default.nix
    ./foot/default.nix
    ./dunst.nix
    ./waybar.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];
}
