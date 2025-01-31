{...}: {
  home-manager = {
    graphical.enable = true;
    colorscheme = "gruvbox";
    wallpaper = "samurai.jpg";
    lid.enable = true;
    touchpad.enable = true;
    hyprland.enable = true;
    gnome.enable = true;
    battery.enable = true;
    backlight.enable = true;
    gaming = {
      enable = true;
      steam.enable = true;
    };
  };
}
