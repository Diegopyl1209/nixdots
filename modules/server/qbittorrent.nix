{
  pkgs,
  lib,
  username,
  config,
  ...
}: {
  options.server.qbittorrent.enable = lib.mkEnableOption "Enable qbittorrent web" // {default = config.server.enable;};
  config = lib.mkIf config.server.qbittorrent.enable {
    services.qbittorrent = {
      enable = true;
      openFirewall = true;
      port = 9092;
      user = username;
      group = "media";
      dataDir = "${config.server.dataDir}/Qbittorrent";
    };
  };
}
