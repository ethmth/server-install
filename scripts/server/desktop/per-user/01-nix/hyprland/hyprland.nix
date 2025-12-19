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

  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;

  imports = [
    ./settings/default.nix
    ./waybar.nix
  ];
}
