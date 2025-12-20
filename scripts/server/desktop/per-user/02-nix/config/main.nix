{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;
  targets.genericLinux.gpu.enable = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  home.packages = with pkgs; [
    mesa-demos
    glmark2
    foot
    fuzzel
    wlogout
    hyprpaper
    grimblast
    hyprpicker
  ];

  imports = [
    ./systemd.nix
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
