{...}: {
  wayland.windowManager.hyprland = {
    # settings.env = [
    #   "WLR_DRM_DEVICES,/home/banana/.config/hypr/card"
    # ];
  };

  home-manager = {
    colorscheme = "gruvbox";
    #wallpaper = "samurai.jpg";
    graphical.enable = true;
    hyprland.enable = true;
    lid.enable = true;
    touchpad.enable = true;
    battery.enable = true;
    backlight.enable = true;
    gaming.enable = true;
  };
}
