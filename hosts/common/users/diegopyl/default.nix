{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.diegopyl = {
    isNormalUser = true;
    description = "Diego Peña y Lillo";
    shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "audio"
      "deluge"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "lxd"
      "minecraft"
      "mysql"
      "network"
      "plugdev"
      "podman"
      "video"
      "wheel"
      "wireshark"
      "media"
    ];
    packages = [pkgs.home-manager];
  };

  home-manager.users.diegopyl = import ../../../../home/diegopyl/${config.networking.hostName}.nix;
}
