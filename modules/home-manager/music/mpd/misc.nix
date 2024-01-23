{pkgs, ...}: {
  # Allows mpd to work with playerctl.
  home.packages = [pkgs.playerctl];
  services.mpdris2.enable = true;
  services.mpris-proxy.enable = true;
  services.playerctld.enable = false;
}
