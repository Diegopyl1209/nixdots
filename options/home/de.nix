{
  config,
  lib,
  isNixOS,
  host,
  ...
}: {
  options.home-manager = {
    gnome.enable = lib.mkEnableOption "Gnome" // {default = isNixOS && config.home-manager.graphical.enable && host != "laptop";};
  };
}
