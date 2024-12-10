{...}: {
  home-manager = {
    graphical.enable = true;
    colorscheme = "gruvbox";
    wallpaper = "samurai.jpg";
    lid.enable = false;
    touchpad.enable = false;
    hyprland.enable = true;
    gnome.enable = true;
    battery.enable = false;
    backlight.enable = false;
    gaming = {
      enable = true;
      steam.enable = true;
    };
  };
}
