{
  lib,
  config,
  username,
  ...
}: let
  wallpaper = "/home/${username}/.config/wallpapers/${config.home-manager.wallpaper}";
in {
  config = lib.mkIf config.home-manager.graphical.enable {
    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = ${wallpaper}

      )}
      splash = false
    '';
  };
}
