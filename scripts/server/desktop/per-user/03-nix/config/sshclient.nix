{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    
    matchBlocks = {
      "e-droplet" = {
        user = "e";
        hostname = "droplet.ethanmt.com";
      };
    };
  };
}

