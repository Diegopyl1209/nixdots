{
  config,
  lib,
  ...
}: let
  backup_dir = "${config.server.dataDir}/Vaultwarden/backup";
in {
  services.vaultwarden = {
    enable = true;
    backupDir = backup_dir;
    config = {
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
    };
  };

  services.caddy.virtualHosts."server.local.com:8223".extraConfig = ''
    reverse_proxy http://127.0.0.1:8222
    tls internal
  '';
}
