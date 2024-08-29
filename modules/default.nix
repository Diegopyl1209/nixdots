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
    ./jellyfin.nix
    ./display-manager.nix
    ./hardware
  ];
}
