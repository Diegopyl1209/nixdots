{lib, ...}: {
  options.home-manager = {
    colorscheme = lib.mkOption {
      type = lib.types.enum ["gruvbox"];
      default = "gruvbox";
    };
    wallpaper = lib.mkOption {
      type = lib.types.str;
    };
  };
}
