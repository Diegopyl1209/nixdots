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
    enable = true;
    dataDir = "/run/media/hdd1/Server/Data";
    mediaDir = "/run/media/hdd1/Server/Media";
    immich.enable = false;
    transmission.enable = false;
  };
  
      fileSystems = {
      "/run/media/hdd1" = {
        device = "/dev/disk/by-uuid/11265333-7f55-4922-b9df-f9e92f6f388d";
        fsType = "btrfs";
        options = ["nofail"];
      };
            "/run/media/hdd2" = {
        device = "/dev/disk/by-uuid/6aafb983-9b7b-4df7-b612-9d0eba95e46b";
        fsType = "btrfs";
        options = ["nofail"];
      };
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
  };
}
