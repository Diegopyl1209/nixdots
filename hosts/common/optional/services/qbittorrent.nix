{
  pkgs,
  lib,
  config,
  ...
}: {
  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    port = 9092;
    user = "diegopyl";
    group = "media";
    dataDir = "${config.server.dataDir}/Qbittorrent";
  };
}
