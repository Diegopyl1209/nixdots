{
  config,
  username,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
  
  #nvidia shit
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.videoDrivers = ["nvidia"];
  
  services.undervolt = {
    enable = true;
    turbo = 1; # disabled
  };
  services.displayManager.autoLogin = {
    user = username;
    enable = true;
  };
  services.getty.autologinUser = username;
  nixos = {
    drives = [
      {
        label = "Disco1";
        mountpoint = "/run/media/hdd1";
        fstype = "btrfs";
      }
      /*
      {
        label = "1tb_hdd";
        mountpoint = "/run/media/hdd";
        fstype = "btrfs";
      }
      */
    ];
  };

  virtualisation.libvirtd.enable = true;

  programs.virt-manager.enable = true;

  # create a tmpfs directory for jellyfin transcoding
  fileSystems."/mnt/transcodes" = {
    fsType = "tmpfs";
    options = ["rw" "nosuid" "inode64" "nodev" "noexec" "size=12G"];
  };
}
