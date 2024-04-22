{
  pkgs,
  inputs,
  config,
  outputs,
  ...
}: let
  buildToolsVersion = "33.0.0";
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [buildToolsVersion "30.0.3"];
    platformVersions = ["30" "31" "33" "34"];
    abiVersions = ["armeabi-v7a" "arm64-v8a"];
    includeNDK = true;
    cmakeVersions = ["3.18.1"];
    ndkVersions = ["25.1.8937393"];
  };
  androidSdk = androidComposition.androidsdk;
in {
  #environment.variables = {
  #  ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
  #};

  programs = {
    steam = {enable = true;};
    zsh = {enable = true;};
    adb = {enable = true;};
    dconf = {enable = true;};
    virt-manager = {enable = true;};
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/diegopyl/nixdots";
  };
  };

  environment.systemPackages = with pkgs; [
    #androidSdk

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
