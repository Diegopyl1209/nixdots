{
  pkgs,
  lib,
  config,
  ...
}: let
  data_folder = "${config.server.dataDir}/Suwayomi";
in {
  options.server.suwayomi.enable = lib.mkEnableOption "Enable Suwayomi" // {default = config.server.enable;};
  config = lib.mkIf config.server.suwayomi.enable {
    systemd.services.docker-suwayomi.serviceConfig = {
      StartLimitBurst = 0;
      RestartSec = 30;
    };

    virtualisation.oci-containers.containers.suwayomi = {
      image = "ghcr.io/suwayomi/tachidesk:stable";
      ports = [
        "100.64.0.3:9900:4567"
      ];
      environment = {
        DOWNLOAD_AS_CBZ = "true";
        AUTO_DOWNLOAD_CHAPTERS = "true";
        AUTO_DOWNLOAD_EXCLUDE_UNREAD = "false";
        MAX_SOURCES_IN_PARALLEL = "6";
        EXTENSION_REPOS = "[\"https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json\"]";
        FLARESOLVERR_ENABLED = "true";
      };
      volumes = [
        "${data_folder}/downloads:/home/suwayomi/.local/share/Tachidesk/downloads"
        "${data_folder}/files:/home/suwayomi/.local/share/Tachidesk"
      ];
    };
  };
}
