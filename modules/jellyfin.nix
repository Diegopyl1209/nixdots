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
        group = "media";
      };
      prowlarr.enable = true;

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
        configDir = "/home/${username}/.local/share/autobrr";
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
