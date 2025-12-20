{ ... }:

let
  # Define monitor presets
  presets = {
    default = [
      ",1920x1080@60,0x0,1"
    ];
    
    home-dual = [
      "DP-1,2560x1440@144,0x0,1"
      "HDMI-A-1,1920x1080@144,2560x0,1"
      ", disable"
    ];
    
    # Add more presets as needed
    # high-res = [
    #   ",2560x1440@60,0x0,1"
    # ];
  };
  
  # Select the active preset here
  activePreset = "home-dual";
in

{
  wayland.windowManager.hyprland.settings.monitor = presets.${activePreset};
}

