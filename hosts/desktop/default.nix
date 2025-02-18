{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/diegopyl

    ../common/optional/gnome.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/nginx.nix
    ../common/optional/steam.nix
  ];

  server = {
    dataDir = "/run/media/hdd1/Server/Data";
    mediaDir = "/run/media/hdd1/Server/Media";
  };

  environment.systemPackages = with pkgs; [
    hello
  ];
  networking = {
    hostName = "desktop";
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  hardware.graphics.enable = true;

  nixos.nvidia = {
    enable = true;
    version = "beta";
  };

  fileSystems = {
    "/run/media/sdd1" = {
      device = "/dev/disk/by-uuid/9084fb93-9cee-4f6e-a672-7fe74e461680";
      fsType = "ext4";
    };
    "/run/media/hdd1" = {
      device = "/dev/disk/by-uuid/a9a2a4d3-43ad-42f4-b6e7-4b31f80feca4";
      fsType = "btrfs";
    };
  };

  system.stateVersion = "22.05";
}
