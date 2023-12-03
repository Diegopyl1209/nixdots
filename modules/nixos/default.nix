{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./i18n.nix
    ./networking.nix
    ./services.nix
    ./sound.nix
    ./virtualisation.nix
    ./misc.nix
    ./hyprland.nix
    ./gnome.nix
    ./awesome
  ];
}
