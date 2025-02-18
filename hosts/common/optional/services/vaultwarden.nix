{
  config,
  lib,
  ...
}: let
  backup_dir = "${config.server.dataDir}/Vaultwarden/backup";
in {
  networking.firewall = {
    allowedTCPPorts = [8222];
  };

  services.vaultwarden = {
    enable = true;
    backupDir = backup_dir;
    config = {
      ROCKET_ADDRESS = "100.64.0.5";
      ROCKET_PORT = 8222;
    };
  };
}
