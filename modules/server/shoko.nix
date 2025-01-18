{
  lib,
  config,
  pkgs,
  username,
  ...
}: let
  data_folder = "${config.server.dataDir}/Shoko";
  media_folder = "${config.server.mediaDir}/R18";
  downloads_folder = "${config.server.mediaDir}/download";
in {
  options.server.shoko.enable = lib.mkEnableOption "Enable Shoko server" // {default = config.server.enable;};
  config = lib.mkIf config.server.shoko.enable {
    virtualisation.oci-containers.containers.shoko = {
      image = "ghcr.io/shokoanime/server:latest";
      ports = [
        "8111:8111"
      ];
      volumes = [
        "${data_folder}:/home/shoko/.shoko"
        "${media_folder}:/mnt/r18"
        "${downloads_folder}:/mnt/downloads"
      ];
      extraOptions = [
        "--pull=always"
        # "--network=host"
      ];
    };
  };
}
