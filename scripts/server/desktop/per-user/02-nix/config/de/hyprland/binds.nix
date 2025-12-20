{
  wayland.windowManager.hyprland.settings.bindm =
    [
      "$mainMod,mouse:272,movewindow"
      "$mainMod,mouse:273,resizewindow"
    ];
  wayland.windowManager.hyprland.settings.bindel = [
    ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
  ];
  wayland.windowManager.hyprland.settings.bindl = [
    ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
  ];
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

      # Mouse Window Actions
      "$mainMod,mouse_down,workspace,e+1"
      "$mainMod,mouse_up,workspace,e-1"

      # Workspace Switching (split-monitor-workspaces)
      "$mainMod ALT,up,workspace,e+1"
      "$mainMod ALT,down,workspace,e-1"

      # Screenshots
      "$mainMod SHIFT,S,exec,hyprctl keyword animation \"fadeOut,0,0,default\"; grimblast --notify copysave area; hyprctl keyword animation \"fadeOut,1,4,default\""
      ",Print,exec,grimblast --notify --cursor copysave output"
      "ALT,Print,exec,grimblast --notify --cursor copysave screen"

      # Color Picker & Lock
      "$mainMod SHIFT,X,exec,hyprpicker -a -n -f hex"
    ]
    ++ builtins.concatLists (
      builtins.genList (i:
        let ws = i + 1;
        in [
          "$mainMod,${toString ws},split-workspace,${toString ws}"
          "$mainMod SHIFT,${toString ws},split-movetoworkspace,${toString ws}"
        ]
      ) 9
    );
}

