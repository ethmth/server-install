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
      "e-lenovo" = {
        user = "e";
        hostname = "lenovo.ethanmt.com";
      };
      "e-flagler" = {
        user = "e";
        hostname = "192.168.0.85";
        proxyJump = "e-lenovo";
      };
      "e-mini-local" = {
        user = "e";
        hostname = "192.168.0.95";
      };
    };
  };
}

