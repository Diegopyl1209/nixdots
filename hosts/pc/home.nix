{
  home-manager = {
    wallpaper = "samurai.jpg";
    graphical.enable = true;
    gnome.enable = true;
    gdm.enable = true;
    colorscheme = "gruvbox";
    lid.enable = false;
    touchpad.enable = false;
    hyprland.enable = false;
    battery.enable = false;
    backlight.enable = false;
    jellyfin.enable = true;
    gaming = {
      enable = true;
      steam.enable = true;
    };
  };
}
