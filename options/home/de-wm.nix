{
  config,
  lib,
  isNixOS,
  host,
  ...
}: {
  options.home-manager = {
    gnome.enable = lib.mkEnableOption "Gnome" // {default = config.home-manager.graphical.enable && host == "pc";};
    hyprland = {
      enable = lib.mkEnableOption "Hyprland" // {default = config.home-manager.graphical.enable && host == "laptop";};
      nvidia = lib.mkEnableOption "Hyprland nvidia compatibility" // {default = false;};
    };

    gdm.enable = lib.mkEnableOption "GDM" // {default = config.home-manager.graphical.enable && host == "pc";};
    tuigreet.enable = lib.mkEnableOption "Tuigreet" // {default = config.home-manager.graphical.enable && host == "laptop";};
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
