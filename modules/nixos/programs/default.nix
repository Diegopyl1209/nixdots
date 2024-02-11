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
    home-manager
    inotify-tools
    udiskie
    libnotify
    pamixer
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
  ];

  # Android
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
