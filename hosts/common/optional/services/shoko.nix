{
  lib,
  config,
  pkgs,
  ...
}: let
  data_folder = "${config.server.dataDir}/Shoko";
  media_folder = "${config.server.mediaDir}/R18";
  downloads_folder = "${config.server.mediaDir}/download";
in {
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
}
