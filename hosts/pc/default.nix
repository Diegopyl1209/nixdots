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

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ${username} qemu-libvirtd -"
  ];

  server = {
    enable = true;
    dataDir = "/run/media/hdd1/Server/Data";
    mediaDir = "/run/media/hdd1/Server/Media";
    immich.enable = false;
    transmission.enable = false;
  };

  nixos = {
    vfio = {
      enable = false;
      acs = true;
      gpuIDs = [
        "10de:2584"
        "10de:2291"
      ];
    };
    amdgpu.enable = true;
    nvidia = {
      drivers = {
        enable = true;
        version = "beta";
        prime = {
          enable = true;
          amdgpuBusId = "PCI:7:0:0";
          nvidiaBusId = "PCI:6:0:0";
        };
      };
    };
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
}
