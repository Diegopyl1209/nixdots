{
  config,
  username,
  lib,
  ...
}: let
  dataDir = "/run/media/hdd1/Server/Data/Flatnotes";
in {
  options.server.flatnotes.enable = lib.mkEnableOption "Enable Flatnotes" // {default = config.server.enable;};
  config = lib.mkIf config.server.flatnotes.enable {
    networking.firewall.allowedTCPPorts = [
      9025
    ];
    virtualisation.oci-containers.containers.flatnotes = {
      image = "dullage/flatnotes:latest";
      ports = [
        "9025:8080"
      ];
      volumes = [
        "${dataDir}/data/:/data"
      ];
      environment = {
        PUID = 1000;
        PGID = 1000;
        FLATNOTES_AUTH_TYPE = "password";
        FLATNOTES_USERNAME = username;
        FLATNOTES_PASSWORD = "changeMe!";
        FLATNOTES_SECRET_KEY = "aLongRandomSeriesOfCharacters"
      };
    };
  };
}
