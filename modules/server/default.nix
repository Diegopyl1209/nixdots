{
  lib,
  config,
  host,
  ...
}: {
  options.server = {
    enable = lib.mkEnableOption "Enable server suite" // {default = host == "server";};
    dataDir = lib.mkOption {
      type = lib.types.str;
      description = "Data dir for services";
    };
    mediaDir = lib.mkOption {
      type = lib.types.str;
      description = "Media dir for services";
    };
  };
  imports = [
    ./transmission.nix
    ./jellyfin.nix
    ./pufferpanel.nix
    ./glance.nix
    ./immich.nix
    ./scrutiny.nix
    ./vaultwarden.nix
    ./freshrss.nix
    ./suwayomi.nix
    ./shoko.nix
    ./qbittorrent.nix
    ./autobrr.nix
  ];
  config = lib.mkIf config.server.enable {
    virtualisation.docker = {
      enable = true;
      extraOptions = "--registry-mirror https://mirror.gcr.io";
    };
    virtualisation.oci-containers.backend = "docker";
  };
}
