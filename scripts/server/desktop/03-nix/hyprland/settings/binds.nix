{ ... }:

{
  wayland.windowManager.hyprland.settings.bind =
    [
      "$mainMod,B,exec,flatpak run io.gitlab.librewolf-community"
      "$mainMod,S,exec,flatpak run com.brave.Browser --enable-features=UseOzonePlatform --ozone-platform=wayland"
      "$mainMod,Q,exec,foot"
    ]
    ++ builtins.concatLists (
      builtins.genList (i:
        let ws = i + 1;
        in [
          "$mainMod, code:1${toString i}, workspace, ${toString ws}"
          "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 9
    );
}
