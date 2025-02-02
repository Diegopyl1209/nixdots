{
  config,
  username,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  services.displayManager.autoLogin = {
    user = username;
    enable = false;
  };
  services.getty.autologinUser = username;

  server = {
    enable = false;
    dataDir = "/run/media/hdd1/Server/Data";
    mediaDir = "/run/media/hdd1/Server/Media";
    immich.enable = false;
    transmission.enable = false;
  };

  nixos = {
    nvidia = {
      drivers = {
        enable = true;
        version = "beta";
      };
    };
    fileSystems = {
      "/run/media/hdd1" = {
        device = "/dev/disk/by-uuid/fbd276d0-7686-4989-81c0-b72656584aad";
        fsType = "exfat";
      };
    };
  };
}
