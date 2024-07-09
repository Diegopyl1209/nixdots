{
  config,
  lib,
  isNixOS,
  host,
  ...
}: {
  options.home-manager = {
    gnome.enable = lib.mkEnableOption "Gnome" // {default = isNixOS && config.home-manager.graphical.enable && host == "pc";};
    hyprland.enable = lib.mkEnableOption "Hyprland" // {default = isNixOS && config.home-manager.graphical.enable && host == "laptop";};
    gdm.enable = lib.mkEnableOption "GDM" // {default = isNixOS && config.home-manager.graphical.enable && host == "pc";};
    tuigreet.enable = lib.mkEnableOption "Tuigreet" // {default = isNixOS && config.home-manager.graphical.enable && host == "laptop";};
  };

  config = {
    assertions = [
      {
        assertion = !(config.home-manager.gdm.enable && config.home-manager.tuigreet.enable);
        message = "Error: gdm.enable and tuigreet.enable cannot be true at the same time.";
      }
    ];
  };
}
