{ pkgs, inputs, ... }:
{
  programs.steam.enable = true;
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    #utils
    distrobox
    appimage-run
    zip
    unzip
    killall
    xdg-utils
    #spotdl
    gtk3
    lutgen
    home-manager
    inotify-tools
    udiskie
    libnotify
    git
    jq
    rxfetch
    pamixer
    nix-prefetch-git
    eww-wayland
    usb-reset
    procps
    hdos
    bolt-launcher
    #vesktop
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
      }
    )


    #gui
    firefox
    armcord
    (mpv.override { scripts = [mpvScripts.mpris]; })
    flatpak

    # gaming
    wineWowPackages.staging
    winetricks
    gamemode
  ];

  # Android
  programs.adb.enable = true;
  services.udev.packages = [
      pkgs.android-udev-rules
    ];

  programs.dconf.enable = true;


}
