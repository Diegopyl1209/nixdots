{
  lib,
  config,
  default,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = config.home-manager.hyprland.enable;
  };
}
