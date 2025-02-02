{
  lib,
  config,
  pkgs,
  username,
  ...
}: {
  options.server.jellyfin.enable = lib.mkEnableOption "Enable jellyfin" // {default = config.server.enable;};
  config = lib.mkIf config.server.jellyfin.enable {
    services = {
      jellyfin = {
        enable = true;
        user = username;
        group = "media";
        openFirewall = true;
        dataDir = "${config.server.dataDir}/jellyfin/dataDir";
        configDir = "${config.server.dataDir}/jellyfin/configDir";
      };

      #prowlarr.enable = true;
     /*
      sonarr = {
        enable = true;
        user = username;
        group = "media";
        openFirewall = true;
        dataDir = "${config.server.dataDir}/sonnar";
      }; */

      autobrr = {
        enable = true;
        user = username;
        group = "media";
        configDir = "${config.server.dataDir}/autobrr";
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
