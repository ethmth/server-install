{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
  };

  imports = [
    ./env.nix
    ./binds.nix
  ];
}

