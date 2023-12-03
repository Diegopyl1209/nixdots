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
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [ 
      libGL
    ]);
  };

  programs.java = {
    enable = true;
    package = pkgs.openjdk17;
  };

  home.packages = with pkgs; [
    lutris
    heroic
    protonup-qt
    cartridges
    micro
    runelite
    neovim
    vesktop
    prismlauncher

    # gui
    d-spy
    github-desktop
    transmission_4-gtk
    android-studio
    jetbrains-toolbox
    zoom-us
    jetbrains.idea-ultimate

    # tools
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

    # frameworks
    love # lua

    # langs
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
