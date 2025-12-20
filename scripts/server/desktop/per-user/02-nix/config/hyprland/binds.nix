{ ... }:

{
  wayland.windowManager.hyprland.settings.bind =
    [
      # App Binds
      "$mainMod,B,exec,flatpak run io.gitlab.librewolf-community"
      "$mainMod,S,exec,flatpak run com.brave.Browser --enable-features=UseOzonePlatform --ozone-platform=wayland"
      "$mainMod,W,exec,cursor"
      "$mainMod,Q,exec,foot"
      "$mainMod,T,exec,thunar"
      "$mainMod,R,exec,fuzzel"
      "$mainMod,Escape,exec,wlogout --protocol layer-shell -b 4 -T 400 -B 400"

      # Window Management
      "$mainMod,C,killactive"
      "$mainMod,F,fullscreen"
      "$mainMod,V,togglefloating"
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
