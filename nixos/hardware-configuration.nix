{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = ["btrfs" "apfs" "xfs"];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.plymouth.enable = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
    extraEntries = ''
      menuentry "MacOS" {
        search --file --no-floppy --set=root /EFI/OC/OpenCore.efi
        chainloader /EFI/OC/OpenCore.efi
      }
    '';
  };

  fileSystems."/run/media/diegopyl/Disco1".device = "/dev/disk/by-uuid/60d52e98-0213-45cb-a59b-b528a3835ac6";

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
