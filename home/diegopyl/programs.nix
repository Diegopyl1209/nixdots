{ pkgs, inputs, ... }:
let
  my-python-packages = ps: with ps; [
    numpy
  ];

in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.java = { 
    enable = true;
    package = pkgs.openjdk11;
  };
  
  home.packages = with pkgs; [
    lutris
    heroic
    protonup-qt
    cartridges
    micro
    runelite
    neovim
    #vesktop
    
    # gui
    d-spy
    github-desktop
    transmission_4-gtk
    android-studio
    jetbrains-toolbox
    zoom-us
    
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
    spotifyd
    
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
