{
  lib,
  config,
  pkgs,
  username,
  ...
}: let
  media_folder = "/run/media/hdd1/Server/Data";
in {
  options.server.jellyfin.enable = lib.mkEnableOption "Enable jellyfin" // {default = config.server.enable;};
  config = lib.mkIf config.server.jellyfin.enable {
    services = {
      jellyfin = {
        enable = true;
        user = username;
        group = "media";
        dataDir = "${media_folder}/jellyfin/dataDir";
        configDir = "${media_folder}/jellyfin/configDir";
      };

      prowlarr.enable = true;

      sonarr = {
        enable = true;
        user = username;
        group = "media";
        dataDir = "${media_folder}/sonnar";
      };

      radarr = {
        enable = true;
        user = username;
        group = "media";
      };
      /*
      transmission = {
        enable = true;
        user = username;
        group = "media";
        settings = {
          download-dir = "${media_folder}/download";
          incomplete-dir = "${media_folder}/download/.incomplete";
        };
      };
      */

      autobrr = {
        enable = true;
        user = username;
        group = "media";
        configDir = "${media_folder}/autobrr";
        package = pkgs.callPackage ./../../pkgs/autobrr/package.nix {};
      };
    };

    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
