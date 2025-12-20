{ config, pkgs, ... }:

let
  netIf = "enp4s0";
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mode = "dock";
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        height = 0;

        modules-left = [
          "clock"
          "hyprland/workspaces"
        ];

        modules-center = [
          "hyprland/window"
        ];

        modules-right = [
          "tray"
          "network"
          "custom/nmvpn"
          "custom/updates"
          "custom/language"
          "battery"
          "backlight"
          "pulseaudio"
          "pulseaudio#microphone"
        ];

        "hyprland/window" = {
          format = "{}";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          on-click = "activate";
        };

        tray = {
          icon-size = 13;
          spacing = 10;
        };

        clock = {
          format = " {:%I:%M %p   %m/%d/%Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [ "" "" "" ];
          on-scroll-up = "brightlight up p";
          on-scroll-down = "brightlight down p";
          min-length = 6;
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            "" "" "" "" ""
            "" "" "" "" "" ""
          ];
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = " Muted";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = " Muted";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
          scroll-step = 5;
        };

        network = {
          interface = netIf;
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname} ";
          format-disconnected = "";
          tooltip-format = "{ifname}";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };

        "custom/nmvpn" = {
          format = "{} {icon}";
          return-type = "json";
          exec = "/usr/local/bin/vpn-listen";
          format-icons = {
            connected = "";
            disconnected = "";
            none = "n";
            error = "⚠";
          };
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Cartograph CF Nerd Font, monospace;
        font-weight: bold;
        font-size: 15px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(21, 18, 27, 0);
        color: #cdd6f4;
      }

      tooltip {
        background: #1e1e2e;
        border-radius: 10px;
        border: 2px solid #11111b;
      }

      #workspaces button {
        padding: 5px;
        color: #313244;
        margin-right: 5px;
      }

      #workspaces button.active {
        color: #a6adc8;
      }

      #workspaces button.focused {
        color: #a6adc8;
        background: #eba0ac;
        border-radius: 10px;
      }

      #workspaces button.urgent {
        color: #11111b;
        background: #a6e3a1;
        border-radius: 10px;
      }

      #workspaces button:hover {
        background: #11111b;
        color: #cdd6f4;
        border-radius: 10px;
      }

      #custom-nmvpn,
      #custom-language,
      #custom-updates,
      #custom-caffeine,
      #custom-weather,
      #window,
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #workspaces,
      #tray,
      #backlight {
        background: #1e1e2e;
        padding: 0 10px;
        margin-top: 10px;
        border-radius: 10px 0 0 10px;
        border: 1px solid #181825;
        border-right: 0;
      }

      #tray {
        border-radius: 10px;
        margin-right: 10px;
      }

      #workspaces {
        border-radius: 10px;
        margin-left: 10px;
        padding-left: 5px;
        padding-right: 0;
      }

      #window {
        border-radius: 10px;
        margin: 0 60px;
      }

      #clock {
        color: #fab387;
        border-radius: 10px;
        margin-left: 5px;
      }

      #network {
        color: #f9e2af;
      }

      #pulseaudio {
        color: #89b4fa;
        border-left: 0;
        border-right: 0;
      }

      #pulseaudio.microphone {
        color: #cba6f7;
        border-radius: 0 10px 10px 0;
        margin-right: 5px;
      }

      #battery {
        color: #a6e3a1;
        border-radius: 0 10px 10px 0;
        margin-right: 10px;
        border-left: 0;
      }

      #custom-nmvpn.disconnected {
        background-color: rgba(245, 60, 60, 0.8);
      }

      #custom-nmvpn.error {
        background-color: rgba(235, 77, 75, 0.8);
      }
    '';
  };
}

