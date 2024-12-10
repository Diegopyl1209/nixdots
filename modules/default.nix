{
  config,
  username,
  ...
}: {
  imports = [
    ./base.nix
    ./display-manager.nix
    ./nix.nix
    ./hyprland.nix
    ./steam.nix
    ./syncthing.nix
    ./hardware
    ./server
    ./gnome.nix
  ];
}
