{
  config,
  lib,
  isNixOS,
  host,
  ...
}: {
  options.home-manager = {
    waybar.enable = lib.mkEnableOption "Waybar" // {default = config.home-manager.hyprland.enable;};
    rofi.enable = lib.mkEnableOption "Rofi" // {default = config.home-manager.hyprland.enable;};
    swaync.enable = lib.mkEnableOption "Sway Notification Center" // {default = config.home-manager.hyprland.enable;};
  };
}
