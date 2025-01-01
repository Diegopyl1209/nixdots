{
  config,
  username,
  ...
}: {
  imports = [
    ./base.nix
    ./display-manager.nix
    ./sops.nix
    ./nix.nix
    ./hyprland.nix
    ./steam.nix
    #./syncthing.nix
    ./hardware
    ./server
    ./gnome.nix
  ];
}
