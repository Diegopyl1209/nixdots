{
  config,
  lib,
  ...
}: let
  data_folder = "${config.server.dataDir}/Freshrss";
in {
  virtualisation.oci-containers.containers.freshrss = {
    image = "freshrss/freshrss:latest";
    ports = [
      "8220:80"
    ];
    environment = {
      TZ = "Santiago/Chile";
      CRON_MIN = "3,33";
      TRUSTED_PROXY = "100.64.0.5/16";
    };
    volumes = [
      "${data_folder}/config:/config"
      "${data_folder}/data:/var/www/FreshRSS/data"
      "${data_folder}/extensions:/var/www/FreshRSS/extensions"
    ];
  };
}
