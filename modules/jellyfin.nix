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
    };
    
     # TODO: Write a proper service module
    systemd.services.autobrr = {
       enable = true;
       description = "runs autobrr as a service";
       unitConfig = {
         Type = "simple";
       };
       serviceConfig = {
         WorkingDirectory = "/home/${username}/.local/share/autobrr/";
         ExecStart = "/home/${username}/.local/share/autobrr/autobrr";
       };
       wantedBy = ["multi-user.target"];
    };
    
    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}