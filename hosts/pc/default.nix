{
  username,
  pkgs,
  ...
}: {
  services.displayManager.autoLogin = {
    user = username;
    enable = true;
  };
  services.getty.autologinUser = username;
}
