{
  description = "Home Manager configuration on Debian";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pam_shim = {
      url = "github:Cu3PO42/pam_shim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };
  };

  outputs = { nixpkgs, home-manager, pam_shim, hyprland, split-monitor-workspaces, ... }:
    let
      system = "x86_64-linux"; # or aarch64-linux
      username = "default"; # leave this as default
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            pam_shim.homeModules.default
            hyprland.homeManagerModules.default
            ./home.nix
            {
              wayland.windowManager.hyprland.plugins = [
                split-monitor-workspaces.packages.${system}.split-monitor-workspaces
              ];
            }
          ];
        };
    };
}
