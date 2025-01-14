{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
  services.logind.powerKey = "ignore";
  server.enable = false;

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    port = 9092;
    #dataDir = "/run/media/hdd1/Server/Data/Qbittorrent";
  };
}
