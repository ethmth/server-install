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
  };

  outputs = { nixpkgs, home-manager, pam_shim, hyprland, ... }:
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
            # {
            #   wayland.windowManager.hyprland = {
            #     enable = true;
            #     # set the flake package
            #     package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            #     portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            #   };
            # }
            hyprland.homeManagerModules.default
            ./home.nix
          ];
        };
    };
}
