{...}: {
  networking.hostName = "nixos";
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };
}
