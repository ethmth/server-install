{ ... }:

{
  wayland.windowManager.hyprland.settings.env = [
    "ELECTRON_OZONE_PLATFORM_HINT,auto"
    "XDG_SCREENSHOTS_DIR,$HOME/Pictures/Screenshots"

    # NVIDIA (optional)
    "LIBVA_DRIVER_NAME,nvidia"
    "XDG_SESSION_TYPE,wayland"
    "GBM_BACKEND,nvidia-drm"
    "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    "NVD_BACKEND,direct"
  ];
}

