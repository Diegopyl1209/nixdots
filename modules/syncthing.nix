{
  config,
  username,
  lib,
  ...
}: {
  options.syncthing.enable = lib.mkEnableOption "Enable syncthing" // {default = true;};
  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
      user = username;
      configDir = lib.mkIf config.server.enable "/run/media/hdd1/Server/Data/Syncthing";
      dataDir = lib.mkIf config.nixos.server.enable "/run/media/hdd1/Server/Sync";
      guiAddress = "0.0.0.0:8384";
    };
  };
}
