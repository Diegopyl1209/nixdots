{
  config,
  pkgs,
  lib,
  utils,
  ...
}:
with lib; let
  cfg = config.services.autobrr;
in {
  options = {
    services.autobrr = {
      enable = mkEnableOption "Autobrr";

      configDir = mkOption {
        type = types.str;
        default = "/var/lib/autobrr/.config/autobrr";
        description = "The directory where Autobrr stores its config files.";
      };

      openFirewall = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Open ports in the firewall for the Autobrr web interface
        '';
      };

      user = mkOption {
        type = types.str;
        default = "autobrr";
        description = "User account under which Autobrr runs.";
      };

      group = mkOption {
        type = types.str;
        default = "autobrr";
        description = "Group under which Autobrr runs.";
      };

      package = mkPackageOption pkgs "autobrr" {};
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d '${cfg.configDir}' 0700 ${cfg.user} ${cfg.group} - -"
    ];

    systemd.services.autobrr = {
      description = "Autobrr";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = utils.escapeSystemdExecArgs [
          (lib.getExe cfg.package)
          "--config=${cfg.configDir}"
        ];
        Restart = "on-failure";
      };
    };

    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [7474];
    };

    users.users = mkIf (cfg.user == "autobrr") {
      autobrr = {
        group = cfg.group;
        home = cfg.configDir;
        uid = 282;
      };
    };

    users.groups = mkIf (cfg.group == "autobrr") {
      autobrr.gid = 282;
    };
  };
}
