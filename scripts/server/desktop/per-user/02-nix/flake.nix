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
  };

  outputs = { nixpkgs, home-manager, pam_shim, ... }:
    let
      system = "x86_64-linux"; # or aarch64-linux
      username = "default"; # leave this as default
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            pam_shim.homeModules.default
          ];
        };
    };
}
