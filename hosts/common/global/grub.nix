{
  config,
  lib,
  ...
}: {
  boot = {
    loader.grub = {
      enable = lib.mkForce true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      extraConfig = "
        terminal_input console
        terminal_output console
      ";
    };

    loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
}
