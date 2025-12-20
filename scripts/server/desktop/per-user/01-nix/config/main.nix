{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;
  targets.genericLinux.gpu.enable = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  home.packages = with pkgs; [
    mesa-demos
    glmark2
    foot
    fuzzel
    wlogout
  ];

  imports = [
    ./hyprland/default.nix
    ./fuzzel/default.nix
    ./wlogout/default.nix
    ./waybar.nix
  ];
}
