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

      # Move Focus
      "$mainMod,left,movefocus,l"
      "$mainMod,right,movefocus,r"
      "$mainMod,up,movefocus,u"
      "$mainMod,down,movefocus,d"
      "$mainMod,H,movefocus,l"
      "$mainMod,L,movefocus,r"
      "$mainMod,K,movefocus,u"
      "$mainMod,J,movefocus,d"

      # Move Window
      "$mainMod SHIFT,left,movewindow,l"
      "$mainMod SHIFT,right,movewindow,r"
      "$mainMod SHIFT,up,movewindow,u"
      "$mainMod SHIFT,down,movewindow,d"
      "$mainMod SHIFT,H,movewindow,l"
      "$mainMod SHIFT,L,movewindow,r"
      "$mainMod SHIFT,K,movewindow,u"
      "$mainMod SHIFT,J,movewindow,d"

      # Resize Active Window
      "$mainMod CTRL,left,resizeactive,-40 0"
      "$mainMod CTRL,right,resizeactive,40 0"
      "$mainMod CTRL,up,resizeactive,0 -40"
      "$mainMod CTRL,down,resizeactive,0 40"
      "$mainMod CTRL,H,resizeactive,-40 0"
      "$mainMod CTRL,L,resizeactive,40 0"
      "$mainMod CTRL,K,resizeactive,0 -40"
      "$mainMod CTRL,J,resizeactive,0 40"
    ]
    ++ builtins.concatLists (
      builtins.genList (i:
        let ws = i + 1;
        in [
          "$mainMod,${toString ws},workspace,${toString ws}"
          "$mainMod SHIFT,${toString ws},movetoworkspace,${toString ws}"
        ]
      ) 9
    );
}

