{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./config.nix
    # ./hyprlock.nix
    # ./hyprpaper.nix
  ];
  config =
    lib.mkIf config.home-manager.hyprland.enable {
    };
}
