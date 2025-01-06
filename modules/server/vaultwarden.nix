{
  config,
  lib,
  useremail,
  ...
}: let
  backup_dir = "/run/media/hdd1/Server/Data/Vaultwarden/backup";
  domain = "diegopyl.duckdns.org";
in {
  options.server.vaultwarden.enable = lib.mkEnableOption "Enable Vaultwarden" // {default = config.server.enable;};
  config = lib.mkIf config.server.vaultwarden.enable {
    networking.firewall = {
      allowedTCPPorts = [8222];
    };

    /*
    # sometimes vpn take a little longer in start and vaultwarden crash if is dont present
    systemd.services.vaultwarden.serviceConfig = {
      StartLimitBurst = 0;
      RestartSec = 30;
      After = "graphical.target";
    };
    */

    services.vaultwarden = {
      enable = true;
      backupDir = backup_dir;
      config = {
        ROCKET_ADDRESS = "100.64.0.3";
        ROCKET_PORT = 8222;
      };
    };
  };
}
