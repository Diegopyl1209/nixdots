{
  username,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
  
  services.displayManager.autoLogin = {
    user = username;
    enable = true;
  };
  services.getty.autologinUser = username;
}
