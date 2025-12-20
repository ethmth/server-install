{ ... }:

{
  wayland.windowManager.hyprland.enable = true; 
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
  };

  imports = [
    ./env.nix
    ./exec.nix
    ./binds.nix
    ./input.nix
    ./general.nix
    ./windowrules.nix
    ./monitors.nix
  ];
}

