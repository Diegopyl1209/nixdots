{ config, pkgs, inputs, outputs,  ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../shared
      ./hyprland.nix
      ./gnome.nix
    ];
  
  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root 061F-8444
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };
  

  users.users.diegopyl = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Diego Peña y Lillo";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.overlays = [
     outputs.overlays.additions
     #outputs.overlays.modifications
  ];


  # Enable the X11 windowing system.
  services.xserver.enable = true;
}
