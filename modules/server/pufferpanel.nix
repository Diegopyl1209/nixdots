{
  config,
  lib,
  ...
}: let
  data_folder = "/run/media/hdd1/Server/Data/Pufferpanel";
in {
  options.server.pufferpanel.enable = lib.mkEnableOption "Enable pufferpanel" // {default = config.server.enable;};
  config = lib.mkIf config.server.pufferpanel.enable {
    virtualisation.oci-containers.containers.pufferpanel = {
      image = "pufferpanel/pufferpanel:latest";
      ports = [
        "8090:8080"
        "5657:5657"
        "25545:25545"
        "7777:7777"
      ];
      environment = {
        PUFFER_DAEMON_CONSOLE_BUFFER = "1000";
        PUFFER_PANEL_REGISTRATIONENABLED = "false";
      };
      volumes = [
        "${data_folder}/etc/pufferpanel:/etc/pufferpanel"
        "${data_folder}/var/lib/pufferpanel:/var/lib/pufferpanel"
        "${data_folder}/var/run/docker.sock:/var/run/docker.sock"
      ];
      extraOptions = [
        "--pull=always"
        #"--network=host"
      ];
    };
  };
}
