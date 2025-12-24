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
          icon-size = 18;
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
          swap-icon-label = false;
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
          swap-icon-label = false;
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
        font-family: Cascadia Code, monospace;
        font-weight: 600;
        font-size: 15px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(0, 0, 0, 0);
        color: #e4e4e7;
      }

      tooltip {
        background: rgba(15, 15, 20, 0.95);
        border-radius: 12px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 8px 12px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
      }

      #workspaces {
        background: rgba(20, 20, 30, 0.85);
        border-radius: 16px;
        margin: 8px 0 8px 12px;
        padding: 3px 6px;
        border: 1px solid rgba(255, 255, 255, 0.08);
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
      }

      #workspaces button {
        padding: 5px 10px;
        color: rgba(255, 255, 255, 0.5);
        margin: 0 2px;
        border-radius: 10px;
        transition: all 0.2s ease;
      }

      #workspaces button.active {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.15);
      }

      #workspaces button.focused {
        color: #ffffff;
        background: linear-gradient(135deg, rgba(99, 102, 241, 0.8), rgba(139, 92, 246, 0.8));
        box-shadow: 0 2px 8px rgba(99, 102, 241, 0.4);
      }

      #workspaces button.urgent {
        color: #ffffff;
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.8), rgba(220, 38, 38, 0.8));
      }

      #workspaces button:hover {
        background: rgba(255, 255, 255, 0.1);
        color: #ffffff;
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
      #tray,
      #backlight {
        background: rgba(20, 20, 30, 0.85);
        padding: 6px 14px;
        margin: 8px 2px;
        border-radius: 12px;
        border: 1px solid rgba(255, 255, 255, 0.08);
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
        transition: all 0.2s ease;
      }

      #custom-nmvpn:hover,
      #custom-language:hover,
      #custom-updates:hover,
      #battery:hover,
      #pulseaudio:hover,
      #network:hover,
      #backlight:hover {
        background: rgba(20, 20, 30, 0.8);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
      }

      #tray {
        margin-right: 24px;
      }

      #window {
        margin: 8px 60px;
        color: rgba(255, 255, 255, 0.9);
      }

      #clock {
        color: #fbbf24;
        margin-left: 16px;
      }

      #network {
        color: #34d399;
      }

      #pulseaudio {
        color: #60a5fa;
      }

      #pulseaudio.microphone {
        color: #a78bfa;
        margin-right: 16px;
      }

      #battery {
        color: #4ade80;
        margin-right: 12px;
      }

      #battery.warning {
        color: #fbbf24;
      }

      #battery.critical {
        color: #f87171;
      }

      #backlight {
        color: #fbbf24;
      }

      #custom-nmvpn.connected {
        color: #4ade80;
      }

      #custom-nmvpn.disconnected {
        background: rgba(239, 68, 68, 0.3);
        color: #fca5a5;
        border-color: rgba(239, 68, 68, 0.4);
      }

      #custom-nmvpn.error {
        background: rgba(220, 38, 38, 0.3);
        color: #f87171;
        border-color: rgba(220, 38, 38, 0.4);
      }
    '';
  };
}

