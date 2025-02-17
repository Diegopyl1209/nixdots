{ lib, ... }:
{
  i18n = {
    defaultLocale = lib.mkDefault "es_MX.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "es_MX.UTF-8";
      LC_ALL = "es_MX.UTF-8";
      LC_ADDRESS = "es_CL.UTF-8";
      LC_IDENTIFICATION = "es_CL.UTF-8";
      LC_MEASUREMENT = "es_CL.UTF-8";
      LC_MONETARY = "es_CL.UTF-8";
      LC_NAME = "es_CL.UTF-8";
      LC_NUMERIC = "es_CL.UTF-8";
      LC_PAPER = "es_CL.UTF-8";
      LC_TELEPHONE = "es_CL.UTF-8";
      LC_TIME = lib.mkDefault "es_CL.UTF-8";
    };
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "es_MX.UTF-8/UTF-8"
    ];
  };
  location.provider = "geoclue2";
  time.timeZone = lib.mkDefault "America/Santiago";
}
