{
  config,
  username,
  ...
}: {
  imports = [
    ./base.nix
    ./docker-compose.nix
    ./nix.nix
    ./hyprland.nix
    ./gnome.nix
    ./steam.nix
    ./display-manager.nix
    ./hardware
  ];
}
