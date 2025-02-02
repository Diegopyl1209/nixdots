{
  config,
  lib,
  useremail,
  ...
}: let
  data_dir = "${config.server.dataDir}/Kavita";
in {
  options.server.kavita.enable = lib.mkEnableOption "Enable Kavita" // {default = config.server.enable;};
  config = lib.mkIf config.server.kavita.enable {
    sops.secrets.kavitaToken = {};
    sops.secrets.komf = {};

    services.kavita = {
      enable = true;
      dataDir = "${data_dir}/Kavita";
      tokenKeyFile = config.sops.secrets.kavitaToken.path;
      settings = {
        Port = 9910;
        IpAddresses = "100.64.0.3";
      };
    };

    virtualisation.oci-containers.containers.komf = {
      image = "sndxr/komf:latest";
      environmentFiles = [
        config.sops.secrets.komf.path
      ];
      environment = {
        KOMF_KAVITA_BASE_URI = "http://100.64.0.3:9910";
      };
      user = "1000:1000";
      volumes = [
        "${data_dir}/Komf:/config"
      ];
      extraOptions = [
        "--pull=always"
        "--network=host"
      ];
    };
  };
}
