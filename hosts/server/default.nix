{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-amd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/diegopyl

    ../common/optional/quietboot.nix

    ../common/optional/services/jellyfin.nix
    ../common/optional/services/vaultwarden.nix
    ../common/optional/services/glance.nix
    ../common/optional/services/freshrss.nix
    ../common/optional/services/suwayomi.nix
    ../common/optional/services/autobrr.nix
    ../common/optional/services/shoko.nix
  ];

  server = {
    dataDir = "/run/media/hdd1/Server/Data";
    mediaDir = "/run/media/hdd1/Server/Media";
  };

  environment.systemPackages = with pkgs; [
    hello
  ];
  networking = {
    hostName = "server";
  };

  fileSystems."/run/media/hdd1" = {
    device = "/dev/disk/by-uuid/1d8863bd-af61-4214-993d-bec7b5f0c0bf";
    fsType = "ext4";
  };


  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  };

  hardware.graphics.enable = true;

  system.stateVersion = "22.05";
}
