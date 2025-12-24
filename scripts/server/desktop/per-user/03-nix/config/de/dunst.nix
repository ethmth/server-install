{ config, pkgs, lib, ... }:

{
  # Enable Dunst service
  services.dunst.enable = true;

  # Dunst configuration
  services.dunst.settings = {
    # Global settings
    global = {
      follow = "mouse";
      indicate_hidden = true;
      offset = "10x10";
      notification_height = 0;
      separator_height = 2;
      padding = 6;
      horizontal_padding = 14;
      text_icon_padding = 8;
      frame_width = 1;
      frame_color = "#FFFFFF14";
      separator_color = "frame";
      sort = true;
      idle_threshold = 120;
      font = "Cascadia Code";
      line_height = 0;
      markup = "full";
      alignment = "left";
      vertical_alignment = "center";
      show_age_threshold = 60;
      word_wrap = true;
      stack_duplicates = true;
      hide_duplicate_count = false;
      show_indicators = true;
      min_icon_size = 0;
      max_icon_size = 64;
      title = "Dunst";
      class = "Dunst";
      corner_radius = 12;
      timeout = 5;
    };

    # Urgency-specific settings
    urgency_low = {
      background = "#14141E";
      foreground = "#E4E4E7";
      frame_color = "#FFFFFF14";
    };

    urgency_normal = {
      background = "#14141E";
      foreground = "#E4E4E7";
      frame_color = "#6366F1";
    };

    urgency_critical = {
      background = "#DC2626";
      foreground = "#F87171";
      frame_color = "#DC2626";
    };
  };
}

