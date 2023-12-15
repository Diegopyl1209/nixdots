{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
  security.polkit.enable = true;
}
