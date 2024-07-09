{...}: {
  home-manager = {
    graphical.enable = true;
    gnome.enable = true;
    gdm.enable = true;
    colorscheme = "gruvbox";
    lid.enable = false;
    touchpad.enable = false;
    hyprland.enable = false;
    battery.enable = false;
    backlight.enable = false;
    gaming = {
      enable = true;
      steam.enable = true;
    };
  };
}
