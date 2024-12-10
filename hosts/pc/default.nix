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

  services.displayManager.autoLogin = {
    user = username;
    enable = false;
  };
  services.getty.autologinUser = username;

  services.undervolt = {
    enable = true;
    turbo = 1; # disabled
  };

  server.enable = true;
  nixos = {
    amdgpu.enable = false;
    nvidia = {
      drivers = {
        version = "beta";
        enable = true;
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
