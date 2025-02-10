{
  config,
  lib,
  username,
  pkgs,
  utils,
  ...
}: let
  data_folder = "${config.server.dataDir}/autobrr";
  package = pkgs.callPackage ./../../pkgs/autobrr/package.nix {};
  group = "media";
in {
  options.server.autobrr.enable = lib.mkEnableOption "Enable Autobrr" // {default = config.server.enable;};
  config = lib.mkIf config.server.autobrr.enable {
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
        Group = group;
        ExecStart = utils.escapeSystemdExecArgs [
          (lib.getExe package)
          "--config=${data_folder}"
        ];
        Restart = "on-failure";
      };
    };
  };
}
