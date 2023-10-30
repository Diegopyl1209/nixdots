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
    gtk3
    lutgen
    home-manager
    inotify-tools
    udiskie
    libnotify
    git
    jq
    rxfetch
    usb-reset
    procps
    

    #gui
    firefox
    armcord
    (mpv.override { scripts = [mpvScripts.mpris]; })

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
