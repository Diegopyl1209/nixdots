{
  pkgs,
  inputs,
  ...
}: let
  my-python-packages = ps:
    with ps; [
      numpy
      ds4drv
    ];
in {
  imports = [
    ./scripts
  ];

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode.fhsWithPackages (ps:
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
  };

  home.packages = with pkgs; [
    # Games
    lutris
    heroic
    protonup-qt
    cartridges
    micro
    runelite
    neovim
    prismlauncher
    alacritty

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
    hsetroot
    catimg
    eza
    dconf
    ranger
    fd
    ripgrep
    fzf
    socat
    htop
    jq
    acpi
    ffmpeg
    stow
    glib
    nodePackages_latest.pnpm
    yarn
    git-lfs
    moreutils
    cava
    mpdris2
    pfetch
    xorg.xev
    procps
    mpc-cli
    playerctl
    recode
    gcc
    zls
    mangohud

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
