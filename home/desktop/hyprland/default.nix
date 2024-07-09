{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.home-manager.hyprland.enable {
    imports = [
      ./config.nix
      ./hyprlock.nix
      ./hyprpaper.nix
    ];

    home.packages = with pkgs; [
      xwaylandvideobridge
      libnotify
      wl-gammarelay-rs
      wayfreeze
      grimblast
      hyprpaper
      hyprpicker
    ];

    # Import wallpaper

    #xdg.configFile."wallpapers" = {
    #  source = ./wallpapers;
    #  recursive = true;
    # executable = false;
    #};

    # start swayidle as part of hyprland, not sway
    # systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];

    # enable hyprland

    wayland.windowManager.hyprland.enable = true;
  };
}
