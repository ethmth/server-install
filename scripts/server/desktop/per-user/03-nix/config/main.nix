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
  ];

  imports = [
    ./systemd.nix
    ./de/main.nix
    ./thunar.nix
    ./sshclient.nix
    ./bin/bin.nix
  ];
}
