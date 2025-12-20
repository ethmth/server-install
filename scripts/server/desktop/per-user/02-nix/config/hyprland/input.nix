{ ... }:

{
  wayland.windowManager.hyprland.settings.input = {
    kb_layout = "us";
    follow_mouse = 1;
    sensitivity = 0.15; # -1.0 - 1.0, 0 means no modification.
    accel_profile = "flat";
    natural_scroll = false;

    touchpad = {
      disable_while_typing = false;
      scroll_factor = 0.7;
      clickfinger_behavior = true;
    };
  };
}

