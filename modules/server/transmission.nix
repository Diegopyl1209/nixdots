{
  pkgs,
  lib,
  username,
  config,
  ...
}: {
  options.server.transmission.enable = lib.mkEnableOption "Enable transmission" // {default = config.server.enable;};
  config = lib.mkIf config.server.transmission.enable {
    services.transmission = {
      enable = true;
      user = username;
      group = "media";
      package = pkgs.transmission_4;
      settings = {
        download-dir = "/run/media/hdd1/Server/Media/download";
        incomplete-dir = "/run/media/hdd1/Server/Media/download/.incomplete";
        rpc-bind-address = "0.0.0.0";
        rpc-port = 9091;
        rcp-whitelist-enabled = 0;
        rpc-whitelist = "*.*.*.*";
      };
    };
  };
}
