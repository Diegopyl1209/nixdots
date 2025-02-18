{
  config,
  lib,
  pkgs,
  utils,
  ...
}: let
  data_folder = "${config.server.dataDir}/autobrr";
  package = pkgs.autobrr;
  username = "diegopyl";
in {
  networking.firewall = {
    allowedTCPPorts = [7474];
  };

  systemd.tmpfiles.rules = [
    "d '${data_folder}' 0700 ${username} ${group} - -"
  ];

  systemd.services.autobrr = {
    description = "Autobrr";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "simple";
      User = username;
      ExecStart = utils.escapeSystemdExecArgs [
        (lib.getExe package)
        "--config=${data_folder}"
      ];
      Restart = "on-failure";
    };
  };
}
