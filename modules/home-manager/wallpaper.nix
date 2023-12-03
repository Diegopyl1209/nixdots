{
  pkgs,
  inputs,
  lib,
  ...
}: {
  options = {
    wallpaper = lib.mkOption {
      default = ../../stow/wallpapers/.wallpapers/aaaaa.jpg;
      type = lib.types.path;
      description = ''
        Path to your Wallpaper
      '';
    };
  };
}
