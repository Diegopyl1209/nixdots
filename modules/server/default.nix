{
  lib,
  config,
  host,
  ...
}: {
  options.server.enable = lib.mkEnableOption "Enable server suite" // {default = host == "server";};
  imports = [
    ./transmission.nix
    ./jellyfin.nix
    #./pihole.nix
  ];
  config = lib.mkIf config.server.enable {
    virtualisation.docker = {
      enable = true;
      extraOptions = "--registry-mirror https://mirror.gcr.io";
    };
    virtualisation.oci-containers.backend = "docker";
  };
}
