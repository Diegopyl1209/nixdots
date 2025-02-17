{
  lib,
  config,
  pkgs,
  ...
}: {
  services = {
    jellyfin = {
      enable = true;
      user = "diegopyl";
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
    };
    */
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
