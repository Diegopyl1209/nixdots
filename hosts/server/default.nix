{...}: {
  # Main drive
  #
  fileSystems."/run/media/hdd" = {
    device = "/dev/disk/by-label/1tb_hdd";
    fsType = "ext4";
  };
  #
  # fileSystems."/run/media/hdd" = {
  #   device = "/dev/disk/by-label/1tb_hdd";
  #   fsType = "btrfs";
  # };
  #
  nixos = {};
}
