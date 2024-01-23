{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs = {
    steam = {enable = true;};
    zsh = {enable = true;};
    adb = {enable = true;};
    dconf = {enable = true;};
    nix-ld = {enable = true;};
    virt-manager = {enable = true;};
  };

  environment.systemPackages = with pkgs; [
    # Utils
    distrobox
    appimage-run
    zip
    unzip
    killall
    xdg-utils
    gtk3
    home-manager
    inotify-tools
    udiskie
    libnotify
    git
    jq
    pamixer
    nix-prefetch-git
    usb-reset
    procps
    nitch
    nix-alien

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
    hdos
    bolt-launcher
  ];

  # Android
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
