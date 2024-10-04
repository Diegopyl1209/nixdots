{
  config,
  pkgs,
  username,
  lib,
  ...
}: let
  media_folder = "/run/media/hdd1/Media";
in {
  config = lib.mkIf config.hm.home-manager.jellyfin.enable {
    services = {
      jellyfin = {
        enable = true;
        user = username;
        group = "media";
        dataDir = "${media_folder}/dataDir/jellyfin/dataDir";
        configDir = "${media_folder}/dataDir/jellyfin/configDir";
      };

      prowlarr.enable = true;

      sonarr = {
        enable = true;
        user = username;
        group = "media";
        dataDir = "${media_folder}/dataDir/sonnar";
      };

      radarr = {
        enable = true;
        user = username;
        group = "media";
      };

      transmission = {
        enable = true;
        user = username;
        group = "media";
        settings = {
          download-dir = "${media_folder}/download";
          incomplete-dir = "${media_folder}/download/.incomplete";
        };
      };

      autobrr = {
        enable = true;
        user = username;
        group = "media";
        configDir = "${media_folder}/dataDir/autobrr";
        package = pkgs.callPackage ./../pkgs/autobrr/package.nix {};
      };
    };

    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
