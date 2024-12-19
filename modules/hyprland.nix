{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.hm.home-manager.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
    programs.hyprlock.enable = true;
    security.pam.services.hyprlock = {};
  };
}
