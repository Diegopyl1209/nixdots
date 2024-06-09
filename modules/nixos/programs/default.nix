{pkgs, ...}: {
  programs = {
    steam.enable = true;
    gamemode.enable = true;
    zsh.enable = true;
    adb.enable = true;
    dconf.enable = true;
    virt-manager.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/diegopyl/nixdots";
    };
    labwc.enable = true;
    waybar.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Utils
    distrobox
    appimage-run
    zip
    unzip
    killall
    xdg-utils
    home-manager
    inotify-tools
    udiskie
    libnotify
    usb-reset
    procps
    nitch

    # Discord with modifications
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })

    # GUI
    armcord
    (mpv.override {scripts = [mpvScripts.mpris];})
    flatpak

    # Gaming
    wineWowPackages.stagingFull
    winetricks
    gamemode
  ];

  # Android
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
