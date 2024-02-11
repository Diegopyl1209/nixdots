{
  pkgs,
  inputs,
  ...
}: let
  my-python-packages = ps:
    with ps; [
      numpy
    ];
in {
  programs = {
    vscode = {
      enable = true;
      package = pkgs.stable.vscode.fhsWithPackages (ps:
        with ps; [
          libGL # Neccesary to debug FabricMC Mods
          flite # Mc Narrator
          usbmuxd
        ]);
    };

    java = {
      enable = true;
      package = pkgs.openjdk17;
    };

    direnv = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    # Games
    lutris
    heroic
    protonup-qt
    cartridges
    runelite
    prismlauncher

    # GUI Applications
    d-spy
    github-desktop
    transmission_4-gtk
    android-studio
    jetbrains-toolbox
    zoom-us
    jetbrains.idea-ultimate

    # Tools
    bat
    bc
    helix
    hsetroot
    catimg
    eza
    fd
    ripgrep
    fzf
    socat
    htop
    jq
    acpi
    ffmpeg
    glib
    nodePackages_latest.pnpm
    yarn
    git-lfs
    moreutils
    cava
    mpdris2
    xorg.xev
    procps
    playerctl
    recode
    gcc
    zls
    mangohud
    imagemagick
    pavucontrol
    blueberry
    swappy
    neovim
    micro
    alacritty

    # Frameworks
    love # lua

    # Languages
    bun
    rustup
    nodejs_20
    luajit
    typescript
    meson
    ninja
    (python3.withPackages my-python-packages)
  ];
}
