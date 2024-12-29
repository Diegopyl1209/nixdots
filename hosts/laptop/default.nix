{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
  services.logind.powerKey = "ignore";
  server.enable = false;
  nixos = {
    hyprland.enable = false;
  };
}
