{
  config,
  pkgs,
  username,
  lib,
  ...
}: let
  media_folder = "/run/media/diegopyl/Disco1/Media";
in {
  config = lib.mkIf config.hm.home-manager.jellyfin.enable {
    services = {
      jellyfin = {
        enable = true;
        user = username;
      };
      prowlarr.enable = true;
      jellyseerr.enable = true;

      sonarr = {
        enable = true;
        user = username;
        group = "media";
      };

      radarr = {
        enable = true;
        user = username;
        group = "media";
      };

      jackett = {
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
    };
    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
