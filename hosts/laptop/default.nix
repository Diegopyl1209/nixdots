{inputs, pkgs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
  services.logind.powerKey = "ignore";
  server.enable = false;

  services.vnstat.enable = true;
  nixos = {
    amdgpu.enable = false;
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
      onevpl-intel-gpu  # for newer GPUs on NixOS <= 24.05
      intel-media-sdk   # for older GPUs
    ];
  };
}
