{ config, pkgs, ... }:

{
  pamShim.enable = true;
  programs.hyprlock.package = config.lib.pamShim.replacePam pkgs.hyprlock;

  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = false;
      };

      background = [
        {
          color = "rgba(0, 0, 0, 0.5)";
          blur_passes = 1;
          blur_size = 10;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      "input-field" = [
        {
          size = "200, 50";
          position = "0, -20";
          monitor = "";
          outline_thickness = 3;
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = false;
          dots_rounding = -1;
          outer_color = "rgb(151, 151, 151)";
          inner_color = "rgb(200, 200, 200)";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = true;
          fade_timeout = 1000;
          placeholder_text = "'<i>Input Password...</i>'";
          hide_input = false;
          check_color = "rgb(204, 136, 34)";
          fail_color = "rgb(204, 34, 34)";
          fail_text = "'<i>$FAIL <b>($ATTEMPTS)</b></i>'";
          fail_timeout = 2000;
          fail_transition = 300;
        }
      ];

      shape = [
        {
          size = "600, 600";
          color = "rgba(31, 29, 46, 1.0)";
          rounding = -1;
          border_size = 20;
          border_color = "rgba(25, 23, 36, 1.0)";
          rotate = 0;
          xray = false;
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
        {
          size = "400, 60";
          color = "rgba(17, 17, 17, 1.0)";
          rounding = -1;
          border_size = 8;
          border_color = "rgba(0, 207, 230, 1.0)";
          rotate = 0;
          xray = false;
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          text = "Shall we play a game?";
          text_align = "center";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 25;
          font_family = "Noto Sans";
          rotate = 0;
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}

