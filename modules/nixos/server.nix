{
  lib,
  config,
  host,
  ...
}: {
  options.server = {
    dataDir = lib.mkOption {
      type = lib.types.str;
      description = "Data dir for services";
    };
    mediaDir = lib.mkOption {
      type = lib.types.str;
      description = "Media dir for services";
    };
  };
}
