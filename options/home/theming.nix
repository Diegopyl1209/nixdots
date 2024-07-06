{lib, ...}: {
  options.home-manager = {
    colorscheme = lib.mkOption {
      type = lib.types.str;
    };
    wallpaper = lib.mkOption {
      type = lib.types.str;
    };
  };
}
