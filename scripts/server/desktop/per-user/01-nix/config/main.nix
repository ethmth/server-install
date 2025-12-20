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
  ];

  imports = [
    ./hyprland/default.nix
    ./waybar.nix
  ];
}
