{ config, pkgs, ... }:

{
  # Enable AwesomeWM
  xsession.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      luarocks # For luarocks.loader
    ];
  };

  # Place the rc.lua configuration file
  xdg.configFile."awesome/rc.lua".source = ./rc.lua;

  # Packages that might be needed by AwesomeWM
  home.packages = with pkgs; [
    xterm  # Default terminal in rc.lua
  ];
}

