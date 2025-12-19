{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
  };

  imports = [
    ./env.nix
    ./exec.nix
    ./binds.nix
  ];
}

