{
  lib,
  config,
  username,
  ...
}: let
  wallpaper = "${config.stylix.image}";
in {
  config = lib.mkIf config.home-manager.graphical.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "${wallpaper}"
        ];
        wallpaper = [
          "${wallpaper}"
        ];
      };
    };
  };
}
